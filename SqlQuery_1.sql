﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'Vidzy.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201808311517043_CreateDatabaseAndAddVideoAndGenreTables'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [ReleaseDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201808311517043_CreateDatabaseAndAddVideoAndGenreTables', N'Vidzy.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D6CACFA535EC5DA44E5204DDC4419C04BD05B434768852944A5281BD459FAC873E525FA143FD8B9464D958A4455B04086C92F3FF713833FEF3F73F261F3621735E41481AF1A97B323A761DE07E1450BE9EBA895ABDFBD6FDF0FECB2F269741B8719E8A7367FA1C527239755F948AC79E27FD1708891C85D417918C566AE447A14782C83B3D3EFECE3B39F10059B8C8CB7126F709573484F40B7E9D45DC87582584DD44013099AFE3CE22E5EADC9210644C7C98BA4F34F8B4759D7346090A5F005BB90EE13C5244A16AE347090B2522BE5EC4B840D8C336063CB7224C42AEF2B83A3E54FBE353ADBD571116ACFC44AA28DC93E1C959EE0ECF243FC8A96EE92E74D8253A566DB5D5A9D3A6EE0FC0055A6E4A1ACF98D0A772878ED263474EFAE5A80C34E241FF1D39B384A944C09443A2046147CE5DB264D4FF11B60FD1CFC0A73C61ACAE076A827B8D055CBA13510C426DEF61956B771DB88ED7A4F34CC292AC4693A97ECDD5D9A9EBDCA270B2645086B966E6424502D03810444170479402C1350F481D65493764E9FF8534C415DE0AD7B9219B8FC0D7EA65EAE247D7B9A21B088A955C83474EF1122191120958426EC92B5DA7FA19E2D0FD1049D7B907966ECB171A67201FA55BCF7934AF4414DE47ACA0C8969F1F8858834275237B6F1125C237349978155A7A319432DA8DA1F4D8FF187A1B0C1942103140245CA086852CFDF9816AD9967143F198C3ED303816906B836301D521703C9732F269AA401D8FB9F0A625973C707A34C96250EA8F71404CD218518872A7EE379667DAF99517ADE2977BA297DFC4AB99625F387C0515A188B2CACA4FE9226C54CBE5C3972EBF7F328788A9BA66BA00558F25E696CAC94DD52DCB9BE4456AB2C8734F1AE4354B0D1E05686A275A30655EFBFEC096CA567A7AC33814A1AC71281C65E694A6492DC02D0358D52F5E56C014858ED751E94C6E481C6362A8553EF98AB3C8CA9ED9BBC5FEC54198F1F07CD9522394DA969230CD913518BB281A35BDA2422A4C28644974FE9805A175AC01D70E2C15A21A88B4035520AC38AE3FD7EEC4A8152295CFAED08C1073736A119891B5E9D23A9330225A1E8959C49290773D347DD459DAAFD3672B36878967286E7AC4B35C6240D374F020F7E737657FF767377E7FF777D0FDDDEEEFE2D07852EB8C1A1B6F1FCE661E6A896991615BE3566CB606A733F7B6D5A9CD1C6CBB615050334E6DA1D56E28E5EEA7529ED40F5429E3B19F4AE6EB6007CE7A24CC23256CCAC7C27814267982DEDD235B193B3BE23AA8FB2BFA09B3F5622B1584237D60B4F885CD1845A056076E08A72B902AABCC5DEC594F8D9EFB9FD3FF7A52066C4813FCE6BD05D52EDDD93DECAACE7BDA09FE4A84FF42C45721D97C5DE764B70C7B367BFF695F0D6AAF02FCAC76B757FBF9FD60A0F6E451FB705786DB1DAF4A4C2D6A566B72CD03D84CDD5F53A2B173FDD3734177E4CC05A697B173ECFCB677342BB5F7135ED0ED21FCA05EB4F52934FB8EDD5DE889F500CFF905E24F8173EE67497646A44F02DB61FA7DEA955EAB0CEA2A0CE95EF5D8165620F455240C9F31A9043E645675732728F7694C58C36AFB2D1E9240B449253F73E70262E03A33D8060E91D6577994AC0DF7EE72406787DF8F9BB67AA516393B68ADF1FA97E1667824DF16377DE5E167C74DFB64C8EEC8078C7EBA273F5975882FDA5267A72C27760C415AA742DD43A136CEED039A76CE5D8AD7373B657498B06B32550E957A07541D6D8F9DEDADFE77E764AA61B4D99B0D9F4A0D31B5987EF59BDADE4ED909CA9AB4BC95A97B0CE0EC1E0A6F67EDD748CC0E92AE2B16FAB7490E7EE35E9667AEF92A2A1284A15171C428616E40112C1CC9B95074457C85DB3E4899FE26F0445882472EC32504D77C9EA838516832844BD6F88D41A7993EF9E994B1A9F3641EA7F3FBCF6102AA4975ED3BE7DF279405A5DE572D5554070B9DBFF22A5FC752E96A7FBD2D39DD467C20A3DC7D65DA7D803066C84CCEF982BCC221BA3D4AF8086BE26F8B56B89BC9EE4034DD3EB9A0642D4828731E153D7E450C07E1E6FD5F00ECF5FF941F0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201808311520260_PopulateGenresTable'
BEGIN
    INSERT INTO Genres(Name) VALUES ('Action')
    INSERT INTO Genres(Name) VALUES ('Thriller')
    INSERT INTO Genres(Name) VALUES ('Family')
    INSERT INTO Genres(Name) VALUES ('Romance')
    INSERT INTO Genres(Name) VALUES ('Comedy')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201808311520260_PopulateGenresTable', N'Vidzy.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB297AD61EF22759222E8260EE224E82DA0A5B14394A254920AEC5DF4C97AE823F5153AD4BF4849968D455AB44580C02639FF1F8733E33F7FFF63F2611332E70584A4119FBA27A363D701EE4701E5EBA99BA8D59B77EE87F75F7F35B908C28DF3589C7BABCF21259753F759A978EC79D27F8690C851487D11C968A5467E147A2488BCD3E3E3EFBD93130F90858BBC1C67729770454348BFE0D759C47D885542D875140093F93AEE2C52AECE0D0941C6C487A9FB48834F5BD7396394A0F005B095EB10CE234514AA367E90B05022E2EB458C0B84DD6F63C0732BC224E42A8FABE343B53F3ED5DA7B1561C1CA4FA48AC23D199EBCCDDDE199E40739D52DDD850EBB40C7AAADB63A75DAD4FD11B840CB4D49E31913FA54EED0517AECC849BF1C9581463CE8BF2367963095089872489420ECC8B94D968CFA3FC1F63EFA05F894278CD5F5404D70AFB1804BB7228A41A8ED1DAC72EDAE02D7F19A749E495892D56832D5AFB87A7BEA3A37289C2C199461AE99B9509100340E045110DC12A54070CD03524759D20D59FA7F210D7185B7C275AEC9E623F0B57A9EBAF8D1752EE906826225D7E08153BC4448A4440296901BF242D7A97E8638743F44D275EE80A5DBF299C619C847E9D6531ECD4B118577112B28B2E5A77B22D6A050DDC8DE5B4489F00D4D265E85965E0CA58C7663283DF63F865E07438610440C1009E7A861214B7FBEA75AB665DC503CE6703B0C8E05E4DAE0584075081CCFA48C7C9A2A50C7632EBC69C9050F9C1E4DB21894FA631C1093344614A2DCA9FB9DE599767EE545ABF8E59EE8E537F16AA6D8170E5F414528A2ACB2F253BA081BD572F9F0A5CBEF9FCC2162AAAE992E40D56389B9A572725375CBF22679919A2CF2DC930679CD528347019ADA89164C99D7BE3FB0A5B2959EDE300E45286B1C0A479939A569520B70CB0056F58B97153045A1E375543A936B12C798186A954FBEE22CB2B267F666B17F7110663C3C5FB6D408A5B6A5244C73640DC62E8A464D2FA9900A130A59129D3F6641681D6BC0B5034B85A80622ED4015082B8EEBCFB53B316A8548E5B34B3423C4DC9C5A0466646DBAB4CE248C8896476216B124E45D0F4D1F7596F6EBF4D98ACD61E2198A9B1EF12C9718D0341D3CC8FDF94DD9DFFDD98DDFDFFD1D747FB7FBBB38349ED43AA3C6C6EB87B399875A625A64D8D6B8159BADC1E9CCBD6D756A3307DB6E1814D48C535B68B51B4AB9FBA99427F50355CA78ECA792F93AD881B31E09F348099BF2B1301E85499EA077F7C856C6CE8EB80EEAFE827EC26CBDD84A05E1481F182D7E65334611A8D5816BC2E90AA4CA2A73171F947746CFFDCFE97F3D290336A4097EF5DE826A97EEEC1E7655E73DED047F21C27F26E29B906CBEAD73B25B863D9BBDFFB4AF06B557017E56BBDBABFDFC7E30507BF2A87DB82BC3ED8E5725A61635AB35B9E2016CA6EEE79468EC5CFDFC54D01D397381E965EC1C3BBFED1DCD4AEDFD8417747B083FA8176D7D0ACDBE6377177A623DC0737E8EF853E09CF959929D11E993C076987E9F7AA5D72A83BA0A43BA573DB68515087D1509C3674C2A810F9955DDDC0ACA7D1A13D6B0DA7E8B8724106D52C9CFDC398718B8CE0CB68143A4F5551E256BC3BDBB1CD0D9E1F7E3A6AD5EA945CE0E5A6BBCFE65B8191EC9D7C54D5F79F8C571D33E19B23BF201A39FEEC94F561DE28BB6D4D929CB891D4390D6A950F750A88D73FB80A69D7397E2F5CD4E191D26EC9A4C9543A5DE015547DB63677BABFFDD39996A186DF666C3A752434C2DA65FFDA6B6B7537682B2262DAF65EA1E0338BB87C2DB59FB3512B383A4EB8A85FE6D9283DFB897E5992BBE8A8A046168541C314A986B50040B477226145D115FE1B60F52A6BF093C1296E0918B7009C1159F272A4E149A0CE192357E63D069A64F7E3A656CEA3C99C7E9FCFE4B98806A525DFBCEF90F096541A9F7654B15D5C142E7AFBCCAD7B154BADA5F6F4B4E37111FC828775F9976EF218C19329373BE202F70886E0F123EC29AF8DBA215EE66B23B104DB74FCE29590B12CA9C47458F5F11C341B879FF170D747589941F0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201808311524059_ChangeVideoTableToOnlyHaveSingleGenre'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [int]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201808311524059_ChangeVideoTableToOnlyHaveSingleGenre', N'Vidzy.Migrations.Configuration',  0x1F8B0800000000000400ED595B6FDB36147E1FB0FF20E8691B52CB495E5AC36E9139C960ACB9204A82BD05B474EC10A3288DA402BBC57ED91EFA93F61776A8BB48D9968D351BB0A1406193E77E3E9E8BF3E71F5FC61F5611735E40481AF3897B3C18BA0EF0200E295F4EDC542DDEBC753FBCFFF69BF14518AD9CC792EE54D321279713F759A964E47932788688C841440311CB78A106411C79248CBD93E1F09D777CEC018A705196E38CEF52AE6804D917FC3A8D7900894A09BB8A4360B238C71B3F93EA5C930864420298B88F34FCB4769D3346092AF7812D5C87701E2BA2D0B4D183045F89982FFD040F08BB5F2780740BC22414268F6AF2BED60F4FB4F55ECD588A0A52A9E2684F81C7A745383C93FDA0A0BA55B83060171858B5D65E67419BB83F0117E8B9A9693465425315011D6464474EF6E5A84A34E241FF3B72A62953A98009875409C28E9CDB74CE68F033ACEFE35F814F78CA58D30EB404EF5A0778742BE204845ADFC1A2B06E16BA8ED7E6F34CC68AADC1939B3EE3EAF4C475AE51399933A8D2DC70D357B100740E045110DE12A540702D03B24059DA0D5DFAFF521BE20A5F85EB5C91D547E04BF53C71F1A3EB5CD21584E54961C103A7F888904989142C25D7E4852E33FB0C75187E88A5EBDC01CBAEE5334D72900FB2ABA7229B97228EEE625672E4C74FF7442C41A1B9B17DE7C7A9080C4BC65E8D96AD18CA04EDC65046F63F865E07438612440C1009E76861A94B7FBEA75AB7E55C5F3C16703B0C8E25E4BAE05842B50F1CCFA48C039A19D0C463A1BCEDC9050F9D2D96E439A8ECC73C202669822844BD13F7072B32DDF2AA8756CB2B22D196371C0C8E4D1F1BDED86F0E1BA1221481563BFA293B8495EA787FD8EC8A27280B9498D66BA13EA8663AB1BCD4716E5B6F39DF662FAB93C55E04D3606F786AC82871D3A0E88095F9F2B7E7B632B6B6D3EB27A1CC6643421928B3ACB45DEAC06E95C07A84F1F219A69C75BC0DC3CEF88A2409D686C6F0539C387E3EF94CDFF8FBCF07512EC30B64C79850595B69C24A479660DCA26AB4F4920AA9B0A69039D125641A4616590BAE1BB054AA6A21D24E5489B0925C7F6EBC89412744EA985DA21B1196E7CC2330336BF365A326614474F48969CCD2886FEA35DBB8F3CADFE4CF4F6C0963CF30DC8C886785C480A619E05EE12F5ECAFEE1CF5FFCFEE1DFC0F74F877F938456576D0A6A5DBC7E3ADB75A823A76585EDCC5B79D92B39BA68764DA9EDE26947A0573E73195D59D511A8F4EE6752D1110E34696F63B0DE85341B4E66520F5AD590D5C751B3A5D8D9B63A8B495261ADEA3046271917557DF76E6D95F99CC475D0F7178C3096787F2D1544034D30F07F63534611DD35C115E1740152E513BD8B5DE8ADB1ABFF7BF6664FCA90F5599E5F7D27A13AA43BB78E5D53FD963584BF10113C13F15D4456DF3725D9ABC69E4BE27F3A56BDD6B2103FAB5E6B59D732F664786EED04331EC26AE27ECE9846CEEC97A792EFC8B911F84447CED0F9FDB09C1FB689355AD17ECB923DB11FB2C221D040681C108635542A8155D4EAC7B7B896073421AC65B3DD42FAA057C7AF9267DE9C43025CC3B2E5561F45DB7A6525D57846BB7CDF731DB5D7801EFBE6E67533EF2EF822E63AB13918376C5E9DABE8E64DB44B72F756F815B7D496F78DE563E75E6A2FB35F6713B5E702444CE3977904ABA4CB5A841E7538042DAC543433BE884BD01A169524463DBB0245B0189233A1E882040AAF039032FB7DEC91B014492EA23984337E93AA2455E8324473D6FABD4D437F9BFE6CDD6EDB3CBE49B2DFB2FE0E17D04CAAEBF90DFF31A52CACECBEB4EBF92611FA4D159D4BE752E90EB65C5792AE63DE535011BEAA14DC43943014266FB84F5EE010DB1E247C842509D6E578B759C8EE44B4C33E3EA7642948240B1935BFFE6B93A7FFDCF4FE2FACAADBEDA01A0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201808311526344_AddClassificationToVideoTable'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [int] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201808311526344_AddClassificationToVideoTable', N'Vidzy.Migrations.Configuration',  0x1F8B0800000000000400ED595B6FDB36147E1FB0FF20E8691B522B97972EB05B746E5218AB93204A8BBD15B474EC10A3288DA402BBC37ED91EF693F6177628513752B665AFED066C285058E43987E7F2F15C983F7FFF63FC729D30EF0984A4299FF867A353DF031EA531E5AB899FABE5B3E7FECB175F7F35BE8A93B5F7BEA2BBD074C8C9E5C47F542ABB0C02193D4242E428A1914865BA54A3284D0212A7C1F9E9E9F7C1D9590028C247599E37BECFB9A209141FF8394D790499CA099BA7313069D671272CA47A37240199910826FE7B1A7FDCF8DE2B46091E1E025BFA1EE13C5544A16A97EF24844AA47C1566B840D8C32603A45B1226C1A87CD9900FD5FEF45C6B1F348C95A828972A4D0E14787661DC11D8EC4739D5AFDD850EBB42C7AA8DB6BA70DAC47F035CA0E5F649975326349571E8A8203BF18A8F933AD08807FDEFC49BE64CE502261C7225083BF1EEF205A3D18FB079487F063EE139636D3D5013DCEB2CE0D29D4833106A730F4BA3DD2CF6BDA0CB17D88C355B8BA7547DC6D5C5B9EFDDE0E164C1A00E73CBCC50A502D0381044417C479402C1B50C281CE59C6E9DA5FFAF4E435CE1ADF0BD3959BF05BE528F131F7FFADE355D435CAD180DDE718A97089994C8C139E4863CD155A19F751CBA1F52E97BF7C08A6DF948B312E4A362EB8389E6B54893FB94551CE5F287072256A050DDD4DD0BD35C449626E3A041CB4E0C1582F663A820FB1F435F0643D621881820125EA386D559FAF703D5673BC6ED963565444ABAA491C94946758D427B6B9FE4AD4837403E0EE81598FB805E5D826140CF9316CC6DE366F29A9155533DF6E1BFCBFF372F02863F06C13608973650BBEE9D43B20061D40F29C342EE7BEF09CBF1F3CC094687FA4DCAE29AF67C37ED9D0E12FAAAA6BF70FD5B7AB2BDF84ACA34A2852FDA79C484B67BDC158FBD1D716E006852D11C5D4833741A4675E27FE7A8DF2FAF4E908D3C83B3AEBCD3D1E8CCB6B0658D9B2BB1815184F2DA6145E4F522AC550F6EB04931D091E676DBDA6BA121A8F665C1B2D0A0B8ABBD637C97BDAA2A0EBB71A6C5DEB2D49251DDCA1645CFA5B533F6EED8D6CA367A06C32454D16C49A81C659783AE493D99A10E60D37A0665EF59F5A8C19626753C27598697B4D5B49A152F2C3BD6E9B3F0F0BE2E29650491EC69EF6A6DEB93B042911558BB78346A7A4D8554580BC882E824368D1387AC03D72D58AA8EEA20D20D5485B08A5CFF6EDD89512F441A9F5DA3190996D5C222B023EBF21523026144F4D4F769CAF2846FEB1176719715BBCD5FAEB812C681A5B8ED91C07189054DDBC183DC6F6ECAE1EE2F6FFCE1EEDFC2F74FBB7F9B844E37D416D4D9182ECFEE0CDA22EDBD2F0F926E76EB414A95B77BD1506D0E0AB94EC57D334B3725BB1E18849252461F56B407EA730F53C9D49923553A5819CCA2312D5A9E99D4CD71DD3C0E31D42E546EB49D7A6593D458ABEB96559FC6A656EC7F69718A4749E27B68FB137A180B47B8910A9291261885BFB029A388EE86604E385D8254655BEB636D7B6EBDDCFC7B5E5102296336E429E58B4FA854BB74EF0C7AE08CD71E4AF91311D12311DF2464FD6D5B923B781EF864F09FF6D5A0213DC6DFEAD30DE985FD074A6AB2514B8633B3CC701C5D4FFC5F0BA64B6FF6D3878AEFC4BB1578D92FBD53EFB7E3D073DCA4D82A6A870D73EE4471CC88899005A1114518666389933C752BFB9DA03CA219611D9DDD6234E41E68FFD5F2EC9DD79001D700EF9835E4A05D55B7966A5DC87DB61F382EBB63CA807978FB385CD629BC5B0B1DD8128C5B26C3DE5179FBA4DC27B97F6AFD8C5374C7FAD670B4776E7687EDCF3329BB1D0622A6F5171F04ABA4AB46846E9A38441DACD43433BE4C2BD05A1A5524563E9B83229856C92BA1E892440AB723C05CA9DF5DCDFBD555B28078C66F7395E50A4D8664C13AEFB81AFABBCE2F9E03BA3A8F6FB3E225F35398806A525D196EF90F396DBDD35DBBF97C9B087DA74C0DD4B154BA16AE36B5A49B940F1464DC57A78207483286C2E42D0FC9131CA3DB3B096F6145A24DD5286E17B23F105DB78F5F53B21224914646C38F9F88E13859BFF80BDD8D7A44F81C0000 , N'6.2.0-61023')
END
