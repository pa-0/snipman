#Requires AutoHotkey v2.0
#Include <JSON>
;default massCode db path
;returns Map of nested Maps defining each snippet:
;Map 1: { title   :  Map #2 }
;Map 2: { Map #3  :  Map #4 }
;Map 3: { folder  :  syntax }
;Map 4: { content : summary }

mcDefaultDir := A_MyDocuments "\massCode\db.json"
parseMassCode(dbPath := mcDefaultDir) {
    dirsMap := Map()    ;{ dirName : folderId }
    snipVal := Map()    ;{ snpName : {snipValue, snipNotes} }
    snipKey := Map()    ;{ snpName : snippId }
    mcIdMap := Map()    ;{ snippId : snipDirId }
    snipMap := Map()    ;{ snpName : { dirname, content } }

    if not FileExist(dbPath) {
        ;MsgBox("massCode database not found.", "db.json not found.")
        return 1
    }

    jsonStr := FileRead(dbPath)
    jsonObj := Json.Load(&jsonStr)
    jKeyDir := jsonObj["folders"]
    jKeySnp := jsonObj["snippets"]
    
    loop jKeyDir.Length {
        dirName := jKeyDir[A_Index]["name"]
        folderId := jKeyDir[A_Index]["id"]
        dirsMap[dirName] := folderId
    }

    loop jKeySnp.Length {
        i := A_Index
        snipDirId := jKeySnp[i]["folderId"]
        snippetId := jKeySnp[i]["id"]
        snipNotes := jKeySnp[i]["description"]
        mcIdMap[snippetId] := snipDirId
        snippTabs := jKeySnp[i]["content"]       
        for snpTab in snippTabs {
            snipValue := jKeySnp[i]["content"][A_Index]["value"]
            snpFrgmnt := jKeySnp[i]["content"][A_Index]["label"]
            snpSyntax := jKeySnp[i]["content"][A_Index]["language"]
            if (snpFrgmnt = "Fragment 1") {
                snpName := jKeySnp[i]["name"]
            }
            else {
                snpPrfx := jKeySnp[i]["name"]          
                snpName := snpPrfx . " (" . A_Index . "): " snpFrgmnt
            }
            snipVal[snpName] := Map(snipValue, snipNotes)
            snipKey[snpName] := Map(snippetId, snpSyntax)
        }
    }

    for sn in snipKey {
        for sid, syn in snipKey[sn] {
            for snid, fid in mcIdMap {
                if (snid = sid) {
                    snipKey[sn] := Map(fid, syn)
                    for dn, di in dirsMap {
                        if (di = fid) {
                            snipKey[sn] := Map(dn, syn)
                        }
                    }        
                }
            }
        }
    }

    for snippetname in snipKey {
        for dn, syn in snipKey[snippetname] {
            for name in snipVal {
                for value, description in snipVal[name] {
                    if (snippetname = name) {
                        snipMap[snippetname] := Map(snipKey[snippetname], snipVal[name])
                    }
                }
            }
        }
    }
    return snipMap
}

/*
testMap := parseMassCode(testPath)
for nm in testMap {
    for nmap1, nmap2 in testMap[nm]
        for dir, syn in nmap1
            for val, summ in nmap2
                if (summ != "")
                    MsgBox "dir:`n" . dir . "`ninfo:`n" . summ . "`nname:`n" . nm . "`ntxt:`n" . val . "`nlang:`n" . syn 
                else
                    MsgBox "dir:`n" . dir . "`nname:`n" . nm . "`ntxt:`n" . val . "`nlang:`n" . syn 
}
*/
