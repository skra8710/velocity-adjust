--
-- Adjust velocity values for Oliver
--

--
-- Sakura
-- October 27, 2018 @ HackOHI/O
--

--
-- Manifest
--
function manifest()
    myManifest = {
        name          = "Velocity Adjustment",
        comment       = "Adjust velocity based on sound",
        author        = "Sakura",
        pluginID      = "{4b94c169-2442-405a-85b3-f5b72900c571}", --GUID or UUID
        pluginVersion = "1.0",
        apiVersion    = "3.0.1.0"
    }
    
    return myManifest
end

-- 
-- Main Function
--
function main(processParam, envParam)
    -- Variables
    local moreVel = {"t s u:", "s u:", "l0 O:", "g V", "g {"}
    local lessVel = {"dZ i:", "dZ {", "dZ V"}
    
	-- get list of notes
	k = 1
    local noteList = {}
	VSSeekToBeginNote()
	retCode, note = VSGetNextNoteEx()
    while (retCode == 1) do
        noteList[k] = note
        k = k + 1
        retCode, note = VSGetNextNoteEx()
    end
    
    noteCount = table.getn(noteList)
    for k = 1, noteCount do
        value = noteList[k].phonemes
        if moreVel[value] then
            noteList[k].velocity = 110
            retCode = VSUpdateNoteEx(noteList[k])
            if (retCode == 0) then
                VSMessageBox("Cannot update notes!", 0)
                break
            end
        end
            
        if lessVel[value] then
            noteList[k].velocity = 30
            retCode = VSUpdateNoteEx(noteList[k])
            if (retCode == 0) then
                VSMessageBox("Cannot update notes!", 0)
                break
            end
        end
    end
end
