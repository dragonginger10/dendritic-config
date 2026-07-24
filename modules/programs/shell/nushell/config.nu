$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.EDITOR = "nvim"

# script for monday aim reports
export def aim [--keep(-k)] {
    const report = '~/Downloads/#Events by Locations_Full Data_data.csv'
    let today = date now | format date '%Y-%m-%d'

    if (which aim-data | length) <= 0 {
        error make {msg: 'Aim-data not installed'}
    }

    aim-data $report
    open result.csv | select `Door Name` `Count` `Week Of` `Common Cause` | to tsv | tail -n +2 | clip.exe
    print "Results copied to clip board"

    if not $keep {
        rm $report
        rm result.csv
    } else {
        mv $report $"($today)-report.csv"
        mv result.csv $"($today)-result.csv"
    }
}

# save epubs
export def mv-epub [] {
    let count = glob ~/Downloads/*.epub | length
    if $count == 0 {
        error make {msg: 'No Ebooks found!'}
    }

    mv '~/Downloads/*.epub' '~/Documents/EPUB/'

    print $'Moved ($count) Ebooks!'
}
