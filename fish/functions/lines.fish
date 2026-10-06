function lines --description 'Count lines of files with the given extension'
    find . -name "*.$argv[1]" | xargs wc -l
end
