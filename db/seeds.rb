if Feeling.count == 0
    Feeling.create([
        {name: 'ほっこりしたい'},
        {name: 'ハラハラ・ドキドキしたい'},
        {name: 'キュンキュンしたい'},
        {name: '思いっきり泣きたい'},
        {name: '笑いたい'}
    ])
end 

if Timer.count == 0
    Timer.create([
        {name: '30分以内'},
        {name: '2時間前後'},
        {name: '2-3日'},
        {name: '3日以上'}
    ])
end 