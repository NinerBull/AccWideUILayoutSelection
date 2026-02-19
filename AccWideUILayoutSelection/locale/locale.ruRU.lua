local L = LibStub("AceLocale-3.0"):NewLocale("AccWideUIAceAddonLocale", "ruRU", false)
if not L then return end

L["ACCWUI_ADDONNAME"] = "Account Wide Interface Settings"
L["ACCWUI_ADDONNAME_SHORT"] = "Интерфейс для всего аккаунта"

L["ACCWUI_LOAD_REGULAR"] = "Аддон Account Wide Interface Settings загружен! Введите %s для настройки."
L["ACCWUI_LOAD_LASTUPDATED"] = "Настройки были в последний раз сохранены %s на %s. (%s)"

L["ACCWUI_OPT_TITLE_DESC"] = "Синхронизирует различные параметры интерфейса для всех ваших персонажей и специализаций."
L["ACCWUI_OPT_EDITMODE_TITLE"] = "Редактировать специальные настройки режима" -- Needs Update

L["ACCWUI_OPT_GROUP_COMBAT"] = COMBAT_LABEL
L["ACCWUI_OPT_GROUP_UNITS"] = "Рамки для модулей и таблички с названиями" -- Needs Update
L["ACCWUI_OPT_GROUP_SOCIAL"] = SOCIAL_LABEL
L["ACCWUI_OPT_GROUP_INTERFACE"] = "HUD и интерфейс" -- Needs Update

L["ACCWUI_OPT_CHK_EDITMODE"] = "Включить выбранный режим редактирования по умолчанию для всех новых персонажей"
L["ACCWUI_OPT_CHK_EDITMODE_DESC"] = "Если этот флажок установлен, все новые создаваемые вами персонажи будут автоматически использовать синхронизированную раскладку режима редактирования. В противном случае вам придётся вручную включить её для каждой спецификации ниже."
L["ACCWUI_OPT_BTN_EDITMODE"] = "Открыть режим редактирования"
L["ACCWUI_OPT_CHK_TOCHAT"] = "Вывод в чат при загрузке аддона"
L["ACCWUI_OPT_CHK_TOCHAT_DESC"] = "Выводит короткое приветственное сообщение в чат после загрузки дополнения после входа в систему." -- Needs Update
L["ACCWUI_OPT_CHK_SCREENSIZE"] = "Сохранение настроек, определенных для разрешения экрана" -- Needs Update
L["ACCWUI_OPT_CHK_SCREENSIZE_DESC"] = "Если этот флажок установлен, определенные настройки будут сохранены и загружены только для полноэкранного разрешения вашего монитора (%s).\n\nЭто может быть полезно, если вы часто играете на разных мониторах или синхронизируете настройки дополнения на нескольких компьютерах.\n\nПоддерживает: выбранный макет режима редактирования, размер и положение окна чата, положение карты зоны" -- Needs Update

L["ACCWUI_OPT_CHK_SHOWLASTSAVED"] = "Вывод в чат при последнем сохранении настроек"
L["ACCWUI_OPT_CHK_SHOWLASTSAVED_DESC"] = "Печатает последнюю дату, время и символ, с которыми был сохранен текущий профиль синхронизации при загрузке." -- Needs Update

L["ACCWUI_OPT_CHK_SHOWBLIZZCHANNELS"] = "Вывод в чат при автоматическом присоединении/выходе из каналов чата Blizzard" -- Needs Update
L["ACCWUI_OPT_CHK_SHOWBLIZZCHANNELS_DESC"] = "Выводится в чат каждый раз, когда дополнение автоматически заставляет вашего персонажа присоединяться к каналу чата или покидать его, в зависимости от настроек в разделе «Каналы чата» Blizzard." -- Needs Update

L["ACCWUI_OPT_SYNCSETTINGS_TITLE"] = "Настройки синхронизации" --Needs Update
L["ACCWUI_OPT_MODULES_TITLE"] = "Переключение синхронизации" --Needs Update
L["ACCWUI_OPT_MODULES_DESC"] = "Какие настройки пользовательского интерфейса вы хотели бы синхронизировать на уровне всего аккаунта?"
L["ACCWUI_OPT_MODULES_EXP_TITLE"] = "Экспериментальные переключатели синхронизации" --Needs Update
L["ACCWUI_OPT_MODULES_EXP_DESC"] = "Эти настройки синхронизации являются экспериментальными, поэтому они могут работать не всегда и могут зависеть от настроек игры и состояния сети."
 --Needs Update
L["ACCWUI_OPT_MODULES_CHK_TARGETING"] = "Настройки таргетинга действий"
L["ACCWUI_OPT_MODULES_CHK_TARGETING_DESC"] = "Если этот флажок установлен, ваши настройки целевого действия синхронизируются." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_ARENA"] = "Настройки окон арены"
L["ACCWUI_OPT_MODULES_CHK_ARENA_DESC"] = "Если этот флажок установлен, настройки окон арены синхронизируются." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT"] = "Настройки авто сбора"
L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT_DESC"] = "Если этот флажок установлен, ваши настройки авто сбора синхронизируются."  --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BAGS"] = "Настройки организации сумки"
L["ACCWUI_OPT_MODULES_CHK_BAGS_DESC"] = "Если этот флажок установлен, ваши назначения сумок, а также настройки «Игнорировать» и «Продавать мусор» синхронизируются.\n\nЭто может быть ненадежным, если условия сети не оптимальны, поскольку каждая настройка пакета должна отправляться по одной за раз." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKGUILD"] = "Настройка блокировки приглашений в гильдию" --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKGUILD_DESC"] = "Если этот флажок установлен, синхронизируются возможности блокировать или разрешать приглашения в гильдию." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKNEIGHBORHOOD"] = "Настройка блокировки приглашений в соседство" --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKNEIGHBORHOOD_DESC"] = "Если флажок установлен, синхронизируется возможность блокировать или разрешать приглашения соседей." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKTRADE"] = "Настройка блокировки торгового запроса" --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKTRADE_DESC"] = "Если этот флажок установлен, синхронизируются возможности блокирования или разрешения торговых запросов." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKCHANNEL"] = "Настройка приглашения на блокировку канала" --Needs Update
L["ACCWUI_OPT_MODULES_CHK_BLOCKCHANNEL_DESC"] = "Если этот флажок установлен, синхронизируются возможности блокировать или разрешать приглашения в чат-канал." --Needs Update
L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW"] = "Настройки окна чата"
L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW_DESC"] = "Если этот параметр отмечен, многие аспекты окон чата, включая вкладки, цвета и типы видимых сообщений, синхронизируются." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION"] = "Настройки положения/размера чата" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION_DESC"] = "Если этот флажок установлен, расположение и размер окон чата синхронизируются."  -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS"] = "Пользовательские каналы чата"
L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS_DESC"] = "Если этот флажок установлен, все пользовательские чат-каналы, к которым вы присоединились, будут синхронизированы."  -- Needs Update
--L["ACCWUI_OPT_MODULES_CHK_COOLDOWN"] = "Настройки трекер восстановления"
--L["ACCWUI_OPT_MODULES_CHK_COOLDOWN_DESC"] = "Если этот флажок установлен, настройки вашего менеджера перезарядки будут синхронизированы."  -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_COOLDOWN"] = "Настройка видимости менеджера перезарядки"
L["ACCWUI_OPT_MODULES_CHK_COOLDOWN_DESC"] = "Если этот параметр отмечен, настройка видимости менеджера перезарядки будет синхронизирована."
L["ACCWUI_OPT_MODULES_CHK_EDITMODE"] = "Выбранный макет режима редактирования"
L["ACCWUI_OPT_MODULES_CHK_EDITMODE_DESC"] = "Если этот флажок установлен, ваш текущий активный макет интерфейса будет синхронизирован."  -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_EMPOWERED"] = "Расширенная настройка касания/удержания"
L["ACCWUI_OPT_MODULES_CHK_EMPOWERED_DESC"] = "Если этот флажок установлен, настройка ввода усиленного заклинания будет синхронизирована." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_LOC"] = "Настройки потери контроля"
L["ACCWUI_OPT_MODULES_CHK_LOC_DESC"] = "Если этот флажок установлен, настройки оповещений о потере управления будут синхронизированы." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER"] = "Настройка наведения мыши" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER_DESC"] = "Если этот флажок установлен, настройка приведения курсора мыши будет синхронизирована." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_SELFCAST"] = "Настройка самостоятельного каста" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_SELFCAST_DESC"] = "Если этот флажок установлен, настройки самостоятельного применения будут синхронизированы." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES"] = "Настройки окон имен"
L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES_DESC"] = "Если этот флажок установлен, настройки вашей таблички будут синхронизированы. \n\nЕсли вы используете Plater, включение этого параметра может помешать работе ваших профилей Plater." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_PARTYRAID"] = "Настройки окон группы/рейда"
L["ACCWUI_OPT_MODULES_CHK_PARTYRAID_DESC"] = "Если этот флажок установлен, настройки вашей группы и фрейма рейда будут синхронизированы. \n\nВ классических клиентах это также приведет к синхронизации профилей ваших фреймов рейда." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY"] = "Настройки наложения заклинаний"
L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY_DESC"] = "Если этот флажок установлен, переключение и непрозрачность наложения оповещений о заклинаниях будут синхронизированы." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP"] = "Просмотренные подсказки к учебнику"
L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP_DESC"] = "Если этот флажок установлен, синхронизируются учебные пособия и информационные фреймы, которые вы уже просмотрели." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS"] = "Видимые панели действий"
L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS_DESC"] = "Если этот флажок установлен, синхронизируется, какие панели действий в данный момент видны.\n\nОн не синхронизирует, какие заклинания и способности вы добавили на панели." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_BTLMAP"] = "Настройки карта игровой зоны"
L["ACCWUI_OPT_MODULES_CHK_BTLMAP_DESC"] = "Если этот флажок установлен, видимость, местоположение и другие параметры карты зоны (по умолчанию: SHIFT+M) синхронизируются." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_ASSISTED"] = "Настройка подсветки с помощью" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_ASSISTED_DESC"] = "Если этот флажок установлен, настройка вспомогательной подсветки будет синхронизирована." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_LOCATIONVIS"] = "Настройка видимости местоположения" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_LOCATIONVIS_DESC"] = "Если этот флажок установлен, настройка видимости местоположения будет синхронизирована.\n\nЭтот параметр определяет, могут ли недавние союзники видеть ваше местоположение, и его можно найти в настройках социальных сетей." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_DMGMETER"] = "Настройки индикатора повреждений" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_DMGMETER_DESC"] = "При включении этой опции будет синхронизироваться видимость индикатора повреждений." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_EXTERNALDEF"] = "Настройка видимости внешней защитыg" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_EXTERNALDEF_DESC"] = "Если этот параметр включен, настройка видимости внешних средств защиты будет синхронизирована." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_WORLDMAP"] = "Настройки карты мира" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_WORLDMAP_DESC"] = "Если этот флажок установлен, будут синхронизированы различные настройки карты мира, такие как фильтры, видимые точки интереса и т. д." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_MINIMAP"] = "Настройки мини-карты" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_MINIMAP_DESC"] = "Если этот флажок установлен, различные настройки мини-карты будут синхронизированы." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CALENDAR"] = "Настройки фильтра календаря" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CALENDAR_DESC"] = "Если этот флажок установлен, выбранные фильтры в игровом календаре будут синхронизированы." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CAMERA"] = "Настройки камеры" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_CAMERA_DESC"] = "Если этот флажок установлен, будут синхронизированы несколько настроек камеры." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_COMBATMISC"] = "Различные боевые настройки" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_COMBATMISC_DESC"] = "Если этот флажок установлен, будут синхронизированы несколько боевых настроек, которые не подходят ни к одной другой категории." -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_UIMISC"] = "Различные настройки пользовательского интерфейса" -- Needs Update
L["ACCWUI_OPT_MODULES_CHK_UIMISC_DESC"] = "Если этот флажок установлен, будут синхронизированы несколько настроек пользовательского интерфейса, которые не подходят ни к одной другой категории." -- Needs Update

L["ACCWUI_OPT_MODULES_CVARS"] = "Список пользовательских CVar" -- Needs Update
L["ACCWUI_OPT_MODULES_CVARS_DESC"] = "Введите пользовательский список CVar, которые вы хотите синхронизировать с этим профилем.\n\nВведите точное имя CVar, по одному в каждой строке." -- Needs Update




L["ACCWUI_BLOCKBLIZZ_TITLE"] = "Каналы чата Blizzard"
L["ACCWUI_BLOCKBLIZZ_DESC"] = "Разрешить или запретить всем персонажам, использующим этот профиль, присоединяться к различным каналам чата по умолчанию" -- Needs Update
L["ACCWUI_BLOCKBLIZZ_TEXT_DESC"] = "Выберите ниже, к каким каналам чата Blizzard ваши персонажи должны всегда присоединяться или к каким из них они должны быть заблокированы, чтобы никогда больше не виделись.\n\nПрисоединиться: ваши персонажи всегда будут пытаться присоединиться к этому каналу.\nБлокировать: ваши персонажи всегда будут покидать этот канал.\nНичего не делать: ваши персонажи не будут принудительно присоединяться к этому каналу или покидать его." -- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHANNEL"] = CHANNEL .. " %s"
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"] = "Выберите, что вы хотите сделать с каналом %s."-- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"] = "Всегда присоединяйтесь"-- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"] = "Всегда уходить"-- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"] = "Ничего не делать"-- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW_DESC"] = "Установка этого флажка заставит всех ваших персонажей присоединиться к каналу %s." -- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK_DESC"] = "Установка этого флажка заставит всех ваших персонажей покинуть канал %s." -- Needs Update
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT_DESC"] = "Если установить этот флажок, дополнение не будет выполнять никаких действий в отношении канала %s." -- Needs Update

L["ACCWUI_CHARSPECIFIC_TITLE"] = "%s Конкретные параметры"
L["ACCWUI_CHARSPECIFIC_DESC"] = "Выберите, следует ли использовать выбранную раскладку режима редактирования для специализаций этого персонажа."

L["ACCWUI_CHARSPECIFIC_CHECK_DESC"] = "Включите синхронизированный макет режима редактирования для %s при переключении на специализацию %s." -- Needs Update

L["ACCWUI_ADCOM_CURRENT"] = "Текущий профиль"
L["ACCWUI_ADCOM_CHANGE"] = "Нажмите, чтобы изменить настройки."

L["ACCWUI_FIRSTTIME_LINE1"] = "Добро пожаловать! Похоже, вы впервые используете этот аддон."
L["ACCWUI_FIRSTTIME_LINE2"] = "Хотите ли вы синхронизировать настройки интерфейса текущего персонажа в качестве базовых настроек для этого аддона?"

L["ACCWUI_FIRSTTIME_BTN1"] = "Используйте текущие настройки %s's"
L["ACCWUI_FIRSTTIME_BTN2"] = "Спросите еще раз позже"

L["ACCWUI_FIRSTTIME_ACCEPTED_LINE1"] = "Ваши настройки теперь сохранены. Они будут синхронизированы со всеми вашими персонажами, включая любые изменения, которые вы можете сделать."
L["ACCWUI_FIRSTTIME_ACCEPTED_LINE2"] = "Введите %s в любое время, чтобы изменить настройки."

L["ACCWUI_FIRSTTIME_DECLINED_LINE1"] = "Вас снова попросят об этом при следующей смене персонажа или обновите интерфейс используя команду /reload."


L["ACCWUI_ADVANCED_DESC"] = "Настройки на этой странице будут применены ко всем профилям вашей учетной записи." -- Needs Update

L["ACCWUI_ADVANCED_ALLOW_CUSTOMCVAR"] = "Разрешить синхронизацию пользовательских CVars" -- Needs Update
L["ACCWUI_ADVANCED_ALLOW_CUSTOMCVAR_DESC"] = "Если этот флажок установлен, в настройках синхронизации станет доступно новое текстовое поле, в котором можно ввести собственный список дополнительных CVars для синхронизации." -- Needs Update
L["ACCWUI_ADVANCED_ALLOW_EXP"] = "Разрешить экспериментальные настройки синхронизации"-- Needs Update
L["ACCWUI_ADVANCED_ALLOW_EXP_DESC"] = "Если этот флажок установлен, будет доступен список экспериментальных настроек синхронизации. \n\nЭти настройки синхронизации могут работать не всегда в зависимости от состояния клиента и сети."-- Needs Update
L["ACCWUI_ADVANCED_DISABLE_AUTO"] = "Отключить автоматическое сохранение/загрузку настроек"-- Needs Update
L["ACCWUI_ADVANCED_DISABLE_AUTO_DESC"] = "Обычно дополнение автоматически сохраняет и загружает ваши настройки при входе в систему, смене профиля и выходе из системы.\n\nЕсли этот параметр отмечен, вам нужно будет вручную сохранять и загружать настройки с помощью кнопок ниже."-- Needs Update
L["ACCWUI_ADVANCED_DISABLE_AUTOSAVE"] = "Отключить только автоматическое сохранение" -- Needs Update
L["ACCWUI_ADVANCED_DISABLE_AUTOSAVE_DESC"] = "Если этот параметр отмечен, дополнение НЕ будет автоматически сохранять ваши настройки при выходе из системы, смене профиля или выходе из режима редактирования.\n\nАвтоматическая загрузка по-прежнему будет происходить при входе в систему или смене профиля.\n\nИспользуйте этот параметр, если хотите загружать настройки, но предотвратить случайное перезаписывание." -- Needs Update
L["ACCWUI_ADVANCED_DISABLE_MINIMAPBTN"] = "Скрыть кнопку мини-карты" -- Needs Update
L["ACCWUI_ADVANCED_DISABLE_MINIMAPBTN_DESC"] = "Если этот параметр отмечен, дополнение НЕ будет добавлять кнопку AWI на мини-карту." -- Needs Update

L["ACCWUI_DEBUG_TITLE"] = BINDING_HEADER_DEBUG

L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT"] = "Вывод Сохранить/Загрузить отладочный текст" -- Needs Update
L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT_DESC"] = "Выводит МНОГО отладочного текста в чат, когда дополнение загружает или сохраняет настройки." -- Needs Update

L["ACCWUI_DEBUG_BTN_FORCELOAD"] = "Принудительная загрузка"
L["ACCWUI_DEBUG_BTN_FORCELOAD_DESC"] = "Немедленно загружает настройки текущего выбранного профиля, перезаписывая любые настройки, которые вы могли изменить с момента последнего сохранения профиля.\n\nОбычно настройки загружаются сразу после входа в систему или после переключения профиля." -- Needs Update
L["ACCWUI_DEBUG_TXT_FORCELOAD"] = "Настройки принудительной загрузки."
L["ACCWUI_DEBUG_BTN_FORCESAVE"] = "Принудительное сохранение"
L["ACCWUI_DEBUG_BTN_FORCESAVE_DESC"] = "Немедленно сохраняет все настройки в текущем выбранном профиле.\n\nОбычно настройки сохраняются непосредственно перед выходом из системы или переключением профиля." -- Needs Update
L["ACCWUI_DEBUG_TXT_FORCESAVE"] = "Настройки принудительного сохранения."

L["ACCWUI_UTILITY_TITLE"] = "Утилиты" -- Needs Update
L["ACCWUI_UTILITY_BTN_ZONEMAPPOS"] = "Сбросить положение карты зоны" -- Needs Update
L["ACCWUI_UTILITY_TXT_ZONEMAPPOS"] = "Перемещает карту зоны в центр экрана. Полезно, если она вышла за пределы экрана и вы не можете её найти." -- Needs Update
L["ACCWUI_UTILITY_BTN_RESETDMGMETER"] = "Сбросить настройки индикатора повреждений" -- Needs Update
L["ACCWUI_UTILITY_TXT_RESETDMGMETER"] = "Сбрасывает все настройки шкалы урона до значений по умолчанию. Полезно, если она застряла в углу экрана и её невозможно переместить.\n\nЭто перезагрузит ваш пользовательский интерфейс." -- Needs Update

L["ACCWUI_JOINING_CHANNEL"] = "Автоматический вход в чат-канал «%s». Введите %s для настройки."  -- Needs Update
L["ACCWUI_LEAVING_CHANNEL"] = "Автоматический выход из чат-канала «%s». Введите %s для настройки."
	
L["ACCWUI_ABOUT"] = "%s от %s - Посвящается Petrel <3" -- Needs Update
L["ACCWUI_ISSUES"] = "Проблемы? Посетите https://github.com/NinerBull/AccWideUILayoutSelection/issues" -- Needs Update

L["ACCWUI_WAIT_TILL_COMBAT"] = "Невозможно загрузить настройки во время боя, они загрузятся после его окончания." -- Needs Update
L["ACCWUI_WAIT_TILL_COMBAT2"] = "Это невозможно сделать во время боя." -- Needs Update

L["ACCWUI_IE_IMPORT"] = "Импортировать профиль" -- Needs Update
L["ACCWUI_IE_EXPORT"] = "Экспортировать профиль" -- Needs Update
L["ACCWUI_IE_IMPORTINTO"] = "Импорт в профиль '%s'" -- Needs Update
L["ACCWUI_IE_IMPORTEXPORT"] = "Профиль импорта/экспорта" -- Needs Update
L["ACCWUI_IE_IMPORTSTRING"] = "Импортировать строку профиля" -- Needs Update
L["ACCWUI_IE_IMPORTSTRING_DESC"] = "Позволяет импортировать профиль, используя текстовую строку, которая была вам предоставлена." -- Needs Update
L["ACCWUI_IE_IMPORTSTRING"] = "Экспортировать строку профиля" -- Needs Update
L["ACCWUI_IE_EXPORTSTRING_DESC"] = "Позволяет экспортировать ваш текущий профиль в виде текстовой строки, которой можно поделиться с другими." -- Needs Update
L["ACCWUI_IE_EXPORT_DESC"] = "Вы можете скопировать приведенную ниже строку и вставить ее в интернет, чтобы поделиться своим текущим профилем с другими, или импортировать его в другую учетную запись WoW, которая принадлежит вам." -- Needs Update
L["ACCWUI_IE_EXPORT_DESC2"] = "Этот экспорт не содержит переменных «Присоединяющиеся каналы чата» или переменной «Последний сохраненный персонаж». Он также не содержит макета режима редактирования, который следует экспортировать отдельно в редакторе макетов режима редактирования." -- Needs Update
L["ACCWUI_IE_IMPORT_DESC"] = "Вставьте строку импорта в поле ниже и нажмите «Импорт профиля». Это импортирует его настройки в выбранный вами профиль, заменив существующие."  -- Needs Update
L["ACCWUI_IE_IMPORT_SUCCESS"] = "Импорт завершен!" -- Needs Update
L["ACCWUI_IE_IMPORT_FAIL"] = "Импорт не удался. Введенная вами строка недопустима." -- Needs Update

L["ACCWUI_TAINTABLES_TITLE"] = "Специально для Midnight" -- Needs Update
L["ACCWUI_TAINTABLES_DESC"] = "Эта вкладка содержит различные синхронизируемые настройки, специфичные для Midnight, которые можно сохранить или загрузить только вручную, поскольку их загрузка необратимо изменяет интерфейс в бою, пока вы не перезагрузите интерфейс.\nВам потребуется вручную загрузить эти настройки для каждого персонажа, с которым вы хотите их использовать." -- Needs Update
L["ACCWUI_TAINTABLES_DESC_SHORT"] = "Содержит различные синхронизируемые настройки, специфичные для Midnight, которые можно сохранить или загрузить только вручную." -- Needs Update
L["ACCWUI_TAINTABLES_RELOADNOW"] = "Настройки загружены. Вам следует немедленно перезагрузить пользовательский интерфейс, чтобы предотвратить проблемы с отображением интерфейса во время боя." -- Needs Update
L["ACCWUI_TAINTABLES_GROUPTITLE"] = "Сохранить/Загрузить настройки" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_LOADALL"] = "Загрузить все настройки" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_LOADALL_DESC"] = "Загружает все доступные настройки с этой вкладки. Потребуется перезагрузка интерфейса." -- Needs Update
L["ACCWUI_TAINTABLES_BTN_SAVEALL"] = "Сохранить все настройки" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_SAVEALL_DESC"] = "Сохраняет все доступные настройки с этой вкладки." -- Needs Update
L["ACCWUI_TAINTABLES_BTN_LOADDM"] = "Настройки индикатора повреждения при загрузке" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_LOADDM_DESC"] = "Загружает сохраненные положения, размеры и видимые типы индикаторов для всех индикаторов урона. Потребуется перезагрузка интерфейса." -- Needs Update
L["ACCWUI_TAINTABLES_BTN_SAVEDM"] = "Сохранение настроек индикатора урона" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_SAVEDM_DESC"] = "Сохраняет текущее положение, размеры и видимые типы индикаторов для всех индикаторов урона." -- Needs Update
L["ACCWUI_TAINTABLES_BTN_LOADVCT"] = "Настройки загрузки каналов чата по вкладкам" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_LOADVCT_DESC"] = "Загружает сохраненные параметры видимости каналов чата, таких как «Общий» и «Торговля», для каждой вкладки чата. Потребуется перезагрузка интерфейса." -- Needs Update
L["ACCWUI_TAINTABLES_BTN_SAVEVCT"] = "Сохранение настроек каналов чата для каждой вкладки" -- Needs Update
L["ACCWUI_TAINTABLES_BTN_SAVEVCT_DESC"] = "Сохраняет видимость каналов чата, таких как «Общий» и «Торговля», для каждой вкладки чата." -- Needs Update