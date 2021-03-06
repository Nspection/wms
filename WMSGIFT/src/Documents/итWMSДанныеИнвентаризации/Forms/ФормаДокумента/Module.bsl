

#Область ОбработчикиСобытий
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() тогда
		Объект.итОснование=Неопределено;
		Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан;
		Объект.Ответственный=ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;	
	Если Параметры.Свойство("итОснование") Тогда 
		Объект.итОснование=Параметры.итОснование;
	КонецЕсли;
	ВидимостьДоступностьЭлементовСервер();
	РассчитатьРезультат();
КонецПроцедуры
&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	Идентификатор=ТекущийЭлемент.ТекущиеДанные.ПолучитьИдентификатор();
	РассчитатьРезультат(Идентификатор);

КонецПроцедуры
&НаКлиенте
Процедура ТоварыКоличествоФактПриИзменении(Элемент)
	Идентификатор=ТекущийЭлемент.ТекущиеДанные.ПолучитьИдентификатор();
	РассчитатьРезультат(Идентификатор);
КонецПроцедуры
&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	РассчитатьРезультат();
	Если ТипЗнч(ЭтаФорма.ВладелецФормы)=Тип("ФормаКлиентскогоПриложения") Тогда 
		Если ЭтаФорма.ВладелецФормы.ИмяФормы = "Документ.итWMSЗадачиИнвентаризации.Форма.ФормаДокумента" Тогда 
			Оповестить("ДокументЗаписанитWMSЗадачиИнвентаризации",Объект.ПометкаУдаления,ЭтаФорма);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ПредставлениеЯчеечногоУчетаКоличествоПланПриИзменении(Элемент)
	Идентификатор=ТекущийЭлемент.ТекущиеДанные.ПолучитьИдентификатор();
	РассчитатьРезультат(Идентификатор);

КонецПроцедуры
&НаКлиенте
Процедура ПредставлениеЯчеечногоУчетаКоличествоФактПриИзменении(Элемент)
	Идентификатор=ТекущийЭлемент.ТекущиеДанные.ПолучитьИдентификатор();
	РассчитатьРезультат(Идентификатор);

КонецПроцедуры


&НаКлиенте
Процедура ПредставлениеЯчеечногоУчетаПередУдалением(Элемент, Отказ)
	Отказ=Истина;
КонецПроцедуры
&НаКлиенте
Процедура ПредставлениеЯчеечногоУчетаПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ=Истина;
КонецПроцедуры
&НаКлиенте
Процедура ПредставлениеЯчеечногоУчетаПередНачаломИзменения(Элемент, Отказ)
	Если ТекущийЭлемент.Имя ="ПредставлениеЯчеечногоУчета"  Тогда 
	СнимокСтрокиПередИзменением= новый Структура;
    СнимокСтрокиПередИзменением.Вставить("Ячейка");
	СнимокСтрокиПередИзменением.Вставить("Номенклатура");
	СнимокСтрокиПередИзменением.Вставить("ДатаРозлива");
	СнимокСтрокиПередИзменением.Вставить("КоличествоПлан");
	СнимокСтрокиПередИзменением.Вставить("КоличествоФакт");
	СнимокСтрокиПередИзменением.Вставить("СерияНоменклатуры");
	СнимокСтрокиПередИзменением.Вставить("Склад");
	СнимокСтрокиПередИзменением.Вставить("Качество");
	СнимокСтрокиПередИзменением.Вставить("Организация");
	ЗаполнитьЗначенияСвойств(СнимокСтрокиПередИзменением,ТекущийЭлемент.ТекущиеДанные);
	КонецЕсли;
	
	
КонецПроцедуры
&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
		Если ИсточникВыбора.ИмяФормы="Документ.итWMSДанныеИнвентаризации.Форма.ФормаВыбораЕНБ"  тогда
			Если ТипЗнч(ВыбранноеЗначение)=Тип("Структура") Тогда
			Оповещение = новый ОписаниеОповещения("ЗаполнитьДаннымиИнвентаризацииОповещение",ЭтаФорма,ВыбранноеЗначение);
	        ПоказатьВопрос(Оповещение,"Документ будет проведен и переведен в статус Зарезервирован",РежимДиалогаВопрос.ДаНет);	
			КонецЕсли;
		КонецЕсли;
		Если ИсточникВыбора.ИмяФормы="Документ.итWMSДанныеИнвентаризации.Форма.ФормаВыбораЗадач"  тогда
			Если ТипЗнч(ВыбранноеЗначение)=Тип("Массив") Тогда
			МассивЯчеек=ПолучитьМассивЯчеекЗадач(ВыбранноеЗначение);
			Если МассивЯчеек.Количество()=0 Тогда 
				Сообщить("ошибка получения ячеек");
				Возврат
			КонецЕсли;	
			Оповещение = новый ОписаниеОповещения("ЗаполнитьДаннымиИнвентаризацииОповещение",ЭтаФорма,МассивЯчеек);
	        ПоказатьВопрос(Оповещение,"Документ будет проведен и переведен в статус Зарезервирован",РежимДиалогаВопрос.ДаНет);	
			КонецЕсли;
		КонецЕсли;

КонецПроцедуры
&НаКлиенте
Процедура ПриОткрытии(Отказ)
    Если ТипЗнч(Объект.итОснование)=Тип("ДокументСсылка.итWMSЗадачиИнвентаризации") и 
			 ЭтаФорма.ВладелецФормы.ИмяФормы = "Документ.итWMSЗадачиИнвентаризации.Форма.ФормаДокумента" Тогда 
		ПерезаполнитьЯчейкиИзОснования("");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКоманд


#Область СборДанныхИнвентаризации


&НаКлиенте
Процедура ЗаполнитьДаннымиИнвентаризации(Команда)
	Оповещение = новый ОписаниеОповещения("ЗаполнитьДаннымиИнвентаризацииОповещение",ЭтаФорма);
	ПоказатьВопрос(Оповещение,"Документ будет проведен и переведен в статус Зарезервирован",РежимДиалогаВопрос.ДаНет);	
КонецПроцедуры
&НаКлиенте
Процедура ЗаполнитьДаннымиИнвентаризацииОповещение(Результат,Параметры)Экспорт
	Если Результат=КодВозвратаДиалога.Нет Тогда 
		Возврат
	КонецЕсли;
	Объект.СтатусДокумента=ВернутьСтатусДокументаПеречисление("Зарезервирован");
	ЭтаФорма.Записать(новый Структура("РежимЗаписи",РежимЗаписиДокумента.Проведение));
	ЗаполнитьДаннымиИнвентаризацииНаСервере(Параметры);
	ВидимостьДоступностьЭлементовКлиент();
	
	
КонецПроцедуры
&НаСервере
Процедура ЗаполнитьДаннымиИнвентаризацииНаСервере(Параметры)
	МассивЯчеек=Неопределено;
	Если ТипЗнч(Параметры)=Тип("Структура") Тогда
		МассивЯчеек=ПолучитьМассивЯчеек(Параметры);
	КонецЕсли;
	Если ТипЗнч(Параметры)=Тип("Массив") Тогда
		МассивЯчеек=Параметры;
	КонецЕсли;
	Данные=РеквизитФормыВЗначение("Объект");
	Данные.ЗаполнитьДаннымиИнвентаризацииНаСервереМодуль(МассивЯчеек);
	ЗначениеВРеквизитФормы(Данные,"Объект");
	РассчитатьРезультат();
КонецПроцедуры


#КонецОбласти
&НаСервере
Процедура ЗаврешитьИнвентаризациюНаСервере()
	//Отказ=Ложь;
	для Каждого стр из Объект.Товары цикл
		Если стр.СерияНоменклатуры= Справочники.СерииНоменклатуры.ПустаяСсылка() тогда
			Сообщить("в строке номер "+стр.НомерСтроки+" не указана серия ");  
			//Отказ=Истина;
		КонецЕсли;
		Если стр.Склад= Справочники.Склады.ПустаяСсылка() тогда
			Сообщить("в строке номер "+стр.НомерСтроки+" не указан Склад ");  
			//Отказ=Истина;
		КонецЕсли;
		
		Если стр.Качество= Справочники.Качество.ПустаяСсылка() тогда
			Сообщить("в строке номер "+стр.НомерСтроки+" не указано Качество ");  
			//Отказ=Истина;
		КонецЕсли;
		
	КонецЦикла;
	//Если Отказ Тогда 
	//	Возврат
	//КонецЕсли;	
	Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Завершен;
КонецПроцедуры

&НаКлиенте
Процедура ЗаврешитьИнвентаризацию(Команда)
	ЗаврешитьИнвентаризациюНаСервере();
	ЭтаФорма.Записать();
	ВидимостьДоступностьЭлементовКлиент();
	
КонецПроцедуры
&НаСервере
Процедура ОтменитьДвиженияДокументаНаСервере()
	Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован;
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьДвиженияДокумента(Команда)
	ОтменитьДвиженияДокументаНаСервере();
	ЭтаФорма.Записать();
	ВидимостьДоступностьЭлементовКлиент();
КонецПроцедуры

&НаКлиенте
Процедура ОставитьВидимостьТолькоСтрокСФактом(Команда)
	ОставитьВидимостьТолькоСтрокСФактомФлаг=Истина;
КонецПроцедуры
&НаКлиенте
Процедура ОтменитьФильтры(Команда)
	ОставитьВидимостьТолькоСтрокСФактомФлаг=Ложь;
КонецПроцедуры
&НаКлиенте
Процедура ВидЯчеечногоУчета(Команда)
	РежимПросмотраПредставление=Истина;
	ЗаполнитьДаннымиПредставленияНаСервере();
	ВидимостьДоступностьЭлементовКлиент();
КонецПроцедуры
&НаКлиенте
Процедура ВидУчетаПаллетВЯчейках(Команда)
	РежимПросмотраПредставление=Ложь;
	ВидимостьДоступностьЭлементовКлиент();
КонецПроцедуры

&НаСервере
Процедура ПечатьВедомостьОтклоненийНаСервере(ТабличныйДокумент)
	Данные=РеквизитФормыВЗначение("Объект");
	Данные.ВедомостьОтклонений(ТабличныйДокумент);
КонецПроцедуры

&НаКлиенте
Процедура ПечатьВедомостьОтклонений(Команда)
	ТабличныйДокумент=новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб=Истина;
	ТабличныйДокумент.ОриентацияСтраницы=ОриентацияСтраницы.Ландшафт;
	ПечатьВедомостьОтклоненийНаСервере(ТабличныйДокумент);
	ТабличныйДокумент.Показать();
КонецПроцедуры
&НаСервере
Процедура ПечатьВедомостьОтклоненийЯчеечногоУчетаНаСервере(ТабличныйДокумент)
	Данные=РеквизитФормыВЗначение("Объект");
	Данные.ВедомостьОтклоненийЯчеечногоУчета(ТабличныйДокумент);
КонецПроцедуры

&НаКлиенте
Процедура ПечатьВедомостьОтклоненийЯчеечногоУчета(Команда)
	ТабличныйДокумент=новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб=Истина;
	ТабличныйДокумент.ОриентацияСтраницы=ОриентацияСтраницы.Ландшафт;
	ПечатьВедомостьОтклоненийЯчеечногоУчетаНаСервере(ТабличныйДокумент);
	ТабличныйДокумент.Показать();
КонецПроцедуры

&НаСервере
Процедура ВедомостьЯчеечногоУчетаНаСервере(ТабличныйДокумент)
	Данные=РеквизитФормыВЗначение("Объект");
	Данные.ВедомостьЯчеечногоУчета(ТабличныйДокумент);
КонецПроцедуры

&НаКлиенте
Процедура ВедомостьЯчеечногоУчета(Команда)
	ТабличныйДокумент=новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб=Истина;
	ТабличныйДокумент.ОриентацияСтраницы=ОриентацияСтраницы.Ландшафт;
	ВедомостьЯчеечногоУчетаНаСервере(ТабличныйДокумент);
	ТабличныйДокумент.Показать();
КонецПроцедуры

&НаСервере
Процедура ПечатьВедомостьНаСервере(ТабличныйДокумент)
Данные=РеквизитФормыВЗначение("Объект");
Данные.Ведомость(ТабличныйДокумент);
	
КонецПроцедуры

&НаКлиенте
Процедура ПечатьВедомость(Команда)
	ТабличныйДокумент=новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб=Истина;
	ТабличныйДокумент.ОриентацияСтраницы=ОриентацияСтраницы.Ландшафт;
	ПечатьВедомостьНаСервере(ТабличныйДокумент);
	ТабличныйДокумент.Показать();
КонецПроцедуры
&НаКлиенте
Процедура ЗаполнитьДаннымиИнвентаризацииСОтбором(Команда)
	ОткрытьФорму("Документ.итWMSДанныеИнвентаризации.Форма.ФормаВыбораЕНБ",,ЭтаФорма);
КонецПроцедуры
&НаКлиенте
Процедура ЗаполнитьДаннымиИнвентаризацииПоЗадачам(Команда)
ОткрытьФорму("Документ.итWMSДанныеИнвентаризации.Форма.ФормаВыбораЗадач",,ЭтаФорма);
КонецПроцедуры

&НаСервере
Процедура ПечатьПустыхЯчеекНаСервере(ТабличныйДокумент)
Данные=РеквизитФормыВЗначение("Объект");
Данные.ПечатьПустыхЯчеек(ТабличныйДокумент);

КонецПроцедуры

&НаКлиенте
Процедура ПечатьПустыхЯчеек(Команда)
	ТабличныйДокумент=новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб=Истина;
	ТабличныйДокумент.ОриентацияСтраницы=ОриентацияСтраницы.Ландшафт;
	ПечатьПустыхЯчеекНаСервере(ТабличныйДокумент);
	ТабличныйДокумент.Показать();
КонецПроцедуры
&НаКлиенте
Процедура ПолучитьДанныеПоРазмещениюSSCC(Команда)
	Если ТекущийЭлемент.Имя="Товары" тогда
		ОткрытьФорму("Документ.итWMSДанныеИнвентаризации.Форма.ФормаДанныхSSCCПриРазмещении",Новый Структура("ИдентификаторУпаковки",ТекущийЭлемент.ТекущиеДанные.ИдентификаторУпаковки));
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ПодсветитьПаллетыПодПодозрением(Команда)
ПодсветитьПаллетыПодПодозрениемНаСервере();
КонецПроцедуры
&НаСервере
Процедура ПодсветитьПаллетыПодПодозрениемНаСервере()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТаблицаИдентификаторов.ИдентификаторУпаковки КАК ИдентификаторУпаковки,
		|	ТаблицаИдентификаторов.Номенклатура,
		|	ТаблицаИдентификаторов.ДатаРозлива,
		|	ТаблицаИдентификаторов.СерияНоменклатуры
		|ПОМЕСТИТЬ ИдентификаторыКПроверке
		|ИЗ
		|	&ТаблицаДанных КАК ТаблицаИдентификаторов
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПОДСТРОКА(ИдентификаторыКПроверке.ИдентификаторУпаковки, 1, 172) КАК ИдентификаторУпаковки,
		|	ИдентификаторыКПроверке.Номенклатура,
		|	ИдентификаторыКПроверке.ДатаРозлива,
		|	ИдентификаторыКПроверке.СерияНоменклатуры
		|ПОМЕСТИТЬ СгруппированныеДанные
		|ИЗ
		|	ИдентификаторыКПроверке КАК ИдентификаторыКПроверке
		|
		|СГРУППИРОВАТЬ ПО
		|	ИдентификаторыКПроверке.Номенклатура,
		|	ИдентификаторыКПроверке.ДатаРозлива,
		|	ИдентификаторыКПроверке.СерияНоменклатуры,
		|	ПОДСТРОКА(ИдентификаторыКПроверке.ИдентификаторУпаковки, 1, 172)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МАКСИМУМ(итWMSРазмещениеТовары.Номенклатура) КАК Номенклатура,
		|	МАКСИМУМ(итWMSРазмещениеТовары.СерияНоменклатуры) КАК СерияНоменклатуры,
		|	итWMSРазмещениеТовары.ИдентификаторУпаковки,
		|	МАКСИМУМ(итWMSРазмещениеТовары.ДатаРозлива) КАК ДатаРозлива
		|ПОМЕСТИТЬ ГруппированныеДанныеИзРазмещений
		|ИЗ
		|	СгруппированныеДанные КАК СгруппированныеДанные
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.итWMSРазмещение.Товары КАК итWMSРазмещениеТовары
		|		ПО СгруппированныеДанные.ИдентификаторУпаковки = итWMSРазмещениеТовары.ИдентификаторУпаковки
		|			И (итWMSРазмещениеТовары.Ссылка.Проведен = ИСТИНА)
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSРазмещениеТовары.ИдентификаторУпаковки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СгруппированныеДанные.ИдентификаторУпаковки,
		|	НЕ СгруппированныеДанные.Номенклатура = ГруппированныеДанныеИзРазмещений.Номенклатура КАК ОшибкаНоменклатуры,
		|	НЕ СгруппированныеДанные.ДатаРозлива = ГруппированныеДанныеИзРазмещений.ДатаРозлива КАК ОшибкаДаты,
		|	НЕ ГруппированныеДанныеИзРазмещений.СерияНоменклатуры = СгруппированныеДанные.СерияНоменклатуры КАК ОшибкаСерии
		|ПОМЕСТИТЬ ДанныеОшибок
		|ИЗ
		|	СгруппированныеДанные КАК СгруппированныеДанные
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ГруппированныеДанныеИзРазмещений КАК ГруппированныеДанныеИзРазмещений
		|		ПО СгруппированныеДанные.ИдентификаторУпаковки = ГруппированныеДанныеИзРазмещений.ИдентификаторУпаковки
		|
		|СГРУППИРОВАТЬ ПО
		|	СгруппированныеДанные.ИдентификаторУпаковки,
		|	НЕ СгруппированныеДанные.Номенклатура = ГруппированныеДанныеИзРазмещений.Номенклатура,
		|	НЕ СгруппированныеДанные.ДатаРозлива = ГруппированныеДанныеИзРазмещений.ДатаРозлива,
		|	НЕ ГруппированныеДанныеИзРазмещений.СерияНоменклатуры = СгруппированныеДанные.СерияНоменклатуры
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДанныеОшибок.ИдентификаторУпаковки
		|ИЗ
		|	ДанныеОшибок КАК ДанныеОшибок
		|ГДЕ
		|	(ДанныеОшибок.ОшибкаНоменклатуры
		|			ИЛИ ДанныеОшибок.ОшибкаДаты
		|			ИЛИ ДанныеОшибок.ОшибкаСерии)";
	
		
	Запрос.УстановитьПараметр("ТаблицаДанных",Объект.Товары.Выгрузить());	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СтрокиДокумента=Объект.Товары.НайтиСтроки(новый Структура("ИдентификаторУпаковки",ВыборкаДетальныеЗаписи.ИдентификаторУпаковки));
		для Каждого Строка из СтрокиДокумента цикл
			Строка.Ошибка=Истина;
		КонецЦикла;
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	КонецПроцедуры

&НаКлиенте
Процедура ПерезаполнитьЯчейкиИзОснования(Команда)
	МассивДокументов=новый Массив;
	МассивДокументов.Добавить(Объект.итОснование);
	МассивЯчеек=ПолучитьМассивЯчеекЗадач(МассивДокументов);
	Если МассивЯчеек.Количество()=0 Тогда 
		Сообщить("ошибка получения ячеек");
		Возврат
	КонецЕсли;
	Оповещение = новый ОписаниеОповещения("ЗаполнитьДаннымиИнвентаризацииОповещение",ЭтаФорма,МассивЯчеек);
	ПоказатьВопрос(Оповещение,"Документ будет проведен и переведен в статус Зарезервирован",РежимДиалогаВопрос.ДаНет);	
КонецПроцедуры
	
#КонецОбласти
#Область СлужебныеПроцедурыИФункции
&НаКлиенте
Процедура ВидимостьДоступностьЭлементовКлиент()
	ВидимостьДоступностьЭлементовСервер();	
КонецПроцедуры

&НаСервере
Процедура ВидимостьДоступностьЭлементовСервер()
	Если Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован тогда
		Элементы.ЗаврешитьИнвентаризацию.Видимость=Истина;
	иначе
		Элементы.ЗаврешитьИнвентаризацию.Видимость=Ложь;
	КонецЕсли;
	Если Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Завершен тогда
		Элементы.Товары.ТолькоПросмотр=Истина;
		Элементы.ОтменитьДвиженияДокумента.Видимость=Истина;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризации.Видимость=Ложь;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризацииСОтбором.Видимость=Ложь;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризацииПоЗадачам.Видимость=Ложь;
        Элементы.ТоварыПерезаполнитьЯчейкиИзОснования.Видимость=Ложь;
	иначе
		Элементы.Товары.ТолькоПросмотр=Ложь;
		Элементы.ОтменитьДвиженияДокумента.Видимость=Ложь;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризации.Видимость=Истина;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризацииСОтбором.Видимость=Истина;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризацииПоЗадачам.Видимость=Истина;
    Если ТипЗнч(Объект.итОснование)=Тип("ДокументСсылка.итWMSЗадачиИнвентаризации") тогда
		Элементы.ТоварыПерезаполнитьЯчейкиИзОснования.Видимость=Истина;
	иначе
		Элементы.ТоварыПерезаполнитьЯчейкиИзОснования.Видимость=Ложь;
	КонецЕсли;
	КонецЕсли;
	Если РежимПросмотраПредставление тогда
		Элементы.Товары.Видимость=Ложь;
		Элементы.ПредставлениеЯчеечногоУчета.Видимость=Истина;
	иначе
		Элементы.Товары.Видимость=Истина;
		Элементы.ПредставлениеЯчеечногоУчета.Видимость=Ложь;
	КонецЕсли;	
	
	Если ТипЗнч(Объект.итОснование)=Тип("ДокументСсылка.итWMSЗадачиИнвентаризации") тогда
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризации.Видимость=Ложь;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризацииСОтбором.Видимость=Ложь;
		Элементы.ТоварыЗаполнитьДаннымиИнвентаризацииПоЗадачам.Видимость=Ложь;
    КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ВернутьСтатусДокументаПеречисление(Имя)
	Возврат Перечисления.итWMSСтатусыСкладскихДокументов[Имя];
КонецФункции

&НаСервере
Процедура РассчитатьРезультат(Строка=Неопределено)
	Если РежимПросмотраПредставление тогда
		Если Строка=Неопределено тогда
			для Каждого стр из Объект.Товары цикл
				стр.Результат=стр.КоличествоФакт-стр.КоличествоПлан;
			КонецЦикла;
			для Каждого стр из ПредставлениеЯчеечногоУчета цикл
				стр.Результат=стр.КоличествоФакт-стр.КоличествоПлан;
			КонецЦикла;
			
		иначе
			СтрокаДанных=ПредставлениеЯчеечногоУчета.НайтиПоИдентификатору(Строка);
			СтрокаДанных.Результат=СтрокаДанных.КоличествоФакт-СтрокаДанных.КоличествоПлан;
			МассивСтрокТовары=Объект.Товары.НайтиСтроки(новый Структура("Ячейка",СтрокаДанных.Ячейка));
			для Каждого  стр из МассивСтрокТовары цикл
				стр.Результат=стр.КоличествоФакт-стр.КоличествоПлан;
			КонецЦикла;
		КонецЕсли;
		
	Иначе 
		Если Строка=Неопределено тогда
			для Каждого стр из Объект.Товары цикл
				стр.Результат=стр.КоличествоФакт-стр.КоличествоПлан;
			КонецЦикла;
		иначе
			СтрокаДанных=Объект.Товары.НайтиПоИдентификатору(Строка);
			СтрокаДанных.Результат=СтрокаДанных.КоличествоФакт-СтрокаДанных.КоличествоПлан;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДаннымиПредставленияНаСервере()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итWMSДанныеИнвентаризацииТовары.Ячейка,
	|	итWMSДанныеИнвентаризацииТовары.Номенклатура,
	|	итWMSДанныеИнвентаризацииТовары.ДатаРозлива,
	|	итWMSДанныеИнвентаризацииТовары.СерияНоменклатуры,
	|	итWMSДанныеИнвентаризацииТовары.Склад,
	|	итWMSДанныеИнвентаризацииТовары.Качество,
	|	итWMSДанныеИнвентаризацииТовары.КоличествоПлан,
	|	итWMSДанныеИнвентаризацииТовары.КоличествоФакт
	|ПОМЕСТИТЬ ВтТовары
	|ИЗ
	|	&Товары КАК итWMSДанныеИнвентаризацииТовары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтТовары.Ячейка,
	|	ВтТовары.Номенклатура,
	|	ВтТовары.ДатаРозлива,
	|	ВтТовары.СерияНоменклатуры,
	|	ВтТовары.Склад,
	|	ВтТовары.Качество,
	|	СУММА(ВтТовары.КоличествоПлан) КАК КоличествоПлан,
	|	СУММА(ВтТовары.КоличествоФакт) КАК КоличествоФакт
	|ПОМЕСТИТЬ ВтГруррированныеДанные
	|ИЗ
	|	ВтТовары КАК ВтТовары
	|
	|СГРУППИРОВАТЬ ПО
	|	ВтТовары.Ячейка,
	|	ВтТовары.Номенклатура,
	|	ВтТовары.ДатаРозлива,
	|	ВтТовары.СерияНоменклатуры,
	|	ВтТовары.Склад,
	|	ВтТовары.Качество
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтГруррированныеДанные.Ячейка,
	|	ВтГруррированныеДанные.Номенклатура,
	|	ВтГруррированныеДанные.ДатаРозлива,
	|	ВтГруррированныеДанные.СерияНоменклатуры,
	|	ВтГруррированныеДанные.Склад,
	|	ВтГруррированныеДанные.Качество,
	|	ВтГруррированныеДанные.КоличествоПлан,
	|	ВтГруррированныеДанные.КоличествоФакт
	|ИЗ
	|	ВтГруррированныеДанные КАК ВтГруррированныеДанные
	|ГДЕ
	|	ВЫБОР
	|			КОГДА ВтГруррированныеДанные.КоличествоФакт = 0
	|					И ВтГруррированныеДанные.КоличествоПлан = 0
	|				ТОГДА ЛОЖЬ
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ";
	
	Запрос.УстановитьПараметр("Товары",Объект.Товары.Выгрузить());
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ПредставлениеЯчеечногоУчета.Очистить();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СтрокаДанных=ПредставлениеЯчеечногоУчета.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаДанных,ВыборкаДетальныеЗаписи);
	КонецЦикла;
    РассчитатьРезультат();	
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецПроцедуры


&НаСервере
Функция ПолучитьМассивЯчеек(СтруктураДанных)
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итСкладскиеЯчейки.Ссылка
	|ИЗ
	|	Справочник.итСкладскиеЯчейки КАК итСкладскиеЯчейки
	|ГДЕ
	|	ВЫБОР
	|			КОГДА &ЗаполнятьПоЯрусам
	|				ТОГДА итСкладскиеЯчейки.Ярус = &ЯрусЗаполнения
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|	И итСкладскиеЯчейки.Ссылка В ИЕРАРХИИ(&Ссылка)
	|	И ВЫБОР
	|			КОГДА &ИгнорироватьЗаблокированные
	|				ТОГДА НЕ итСкладскиеЯчейки.Заблокирована
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|	И итСкладскиеЯчейки.ЭтоГруппа = ЛОЖЬ
	|	И итСкладскиеЯчейки.ПометкаУдаления = ЛОЖЬ
	|
	|УПОРЯДОЧИТЬ ПО
	|	итСкладскиеЯчейки.Ярус";
	
	Запрос.УстановитьПараметр("ЗаполнятьПоЯрусам", СтруктураДанных.ЗаполнятьПоЯрусам);
	Запрос.УстановитьПараметр("ИгнорироватьЗаблокированные", СтруктураДанных.ИгнорироватьЗаблокированные);
	Запрос.УстановитьПараметр("Ссылка", СтруктураДанных.Ссылка);
	Запрос.УстановитьПараметр("ЯрусЗаполнения", СтруктураДанных.ЯрусЗаполнения);

	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	Возврат РезультатЗапроса;
	
		//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	
КонецФункции

&НаСервере
Функция ПолучитьМассивЯчеекЗадач(МассивЗадач)	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSЗадачиИнвентаризацииЗаданияПоЯчейкам.Ячейка
		|ИЗ
		|	Документ.итWMSЗадачиИнвентаризации.ЗаданияПоЯчейкам КАК итWMSЗадачиИнвентаризацииЗаданияПоЯчейкам
		|ГДЕ
		|	итWMSЗадачиИнвентаризацииЗаданияПоЯчейкам.Ссылка В(&МассивЗадач)
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSЗадачиИнвентаризацииЗаданияПоЯчейкам.Ячейка";
	
	Запрос.УстановитьПараметр("МассивЗадач", МассивЗадач);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	МассивЯчеек = РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Ячейка");
	Возврат МассивЯчеек;
КонецФункции











#КонецОбласти








