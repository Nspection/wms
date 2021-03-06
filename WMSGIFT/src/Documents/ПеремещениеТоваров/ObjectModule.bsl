#Если НаСервере Тогда
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSПеремещение") 
		или ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSИзменениеПараметровТовараВЯчейках") 
			или ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSСписаниеТовара")
			Тогда 
		ЗаполнитьнаОснованииWMS(ДанныеЗаполнения);
	КонецЕсли;	

	КонецПроцедуры
	
Процедура ЗаполнитьнаОснованииWMS(ДанныеЗаполнения)
	Если ПроверкаНаНаличиеПеремещенияПоОснованию(ДанныеЗаполнения) Тогда 
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("У основания уже имеется проведенное перемещение");
		Возврат;
	КонецЕсли;
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSСписаниеТовара") 
	или ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSНаборка")  Тогда 
	СкладОтправитель=ДанныеЗаполнения.Склад;
	СкладПолучатель=ДанныеЗаполнения.Склад;
    Иначе
	СкладОтправитель=ДанныеЗаполнения.СкладОтправитель;
	СкладПолучатель=ДанныеЗаполнения.СкладПолучатель;
	КонецЕсли;
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSИзменениеПараметровТовараВЯчейках") Тогда 
	Организация=ДанныеЗаполнения.ОрганизацияОтправитель;
	иначе
	Организация=ДанныеЗаполнения.Организация;
	КонецЕсли;
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSНаборка")  Тогда
		ПеремещениеНаУдаленныйСклад=Истина;
	КонецЕсли;
	Основание=ДанныеЗаполнения;
	Дата=ТекущаяДатаСеанса();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSПеремещениеТовары.Номенклатура КАК Номенклатура,
		|	итWMSПеремещениеТовары.СерияНоменклатуры КАК СерияНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSПеремещениеТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSПеремещениеТовары.Качество
		|	КОНЕЦ КАК Качество,
		|	СУММА(ВЫБОР
		|		КОГДА итWMSПеремещениеТовары.ФиксацияСтроки
		|			ТОГДА итWMSПеремещениеТовары.КоличествоФакт
		|		ИНАЧЕ итWMSПеремещениеТовары.Количество
		|	КОНЕЦ) КАК Количество,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков КАК ЕдиницаИзмерения,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест КАК ЕдиницаИзмеренияМест,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент КАК Коэффициент,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент КАК КоэффициентМест,
		|	итWMSПеремещениеТовары.Характеристика КАК ХарактеристикаНоменклатуры
		|ИЗ
		|	Документ.итWMSПеремещение.Товары КАК итWMSПеремещениеТовары
		|ГДЕ
		|	итWMSПеремещениеТовары.Ссылка.Проведен
		|	И итWMSПеремещениеТовары.СостояниеЗадачи <> ЗНАЧЕНИЕ(Перечисление.итwmsсостоянияЗадачТсд.Отменена)
		|	И итWMSПеремещениеТовары.Ссылка = &Ссылка
		|СГРУППИРОВАТЬ ПО
		|	итWMSПеремещениеТовары.Номенклатура,
		|	итWMSПеремещениеТовары.СерияНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSПеремещениеТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSПеремещениеТовары.Качество
		|	КОНЕЦ,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSПеремещениеТовары.Характеристика
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	итWMSРучноеПеремещениеТовары.Номенклатура,
		|	итWMSРучноеПеремещениеТовары.СерияНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSРучноеПеремещениеТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSРучноеПеремещениеТовары.Качество
		|	КОНЕЦ,
		|	СУММА(итWMSРучноеПеремещениеТовары.Количество),
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSРучноеПеремещениеТовары.Характеристика
		|ИЗ
		|	Документ.итWMSРучноеПеремещение.Товары КАК итWMSРучноеПеремещениеТовары
		|ГДЕ
		|	итWMSРучноеПеремещениеТовары.Ссылка.Проведен
		|	И итWMSРучноеПеремещениеТовары.Ссылка = &Ссылка
		|СГРУППИРОВАТЬ ПО
		|	итWMSРучноеПеремещениеТовары.Номенклатура,
		|	итWMSРучноеПеремещениеТовары.СерияНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSРучноеПеремещениеТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSРучноеПеремещениеТовары.Качество
		|	КОНЕЦ,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSРучноеПеремещениеТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSРучноеПеремещениеТовары.Характеристика
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.СерияНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSИзменениеПараметровТовараВЯчейкахТовары.КачествоИзменения = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSИзменениеПараметровТовараВЯчейкахТовары.КачествоИзменения
		|	КОНЕЦ,
		|	СУММА(итWMSИзменениеПараметровТовараВЯчейкахТовары.КоличествоИзменения),
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Характеристика
		|ИЗ
		|	Документ.итWMSИзменениеПараметровТовараВЯчейках.Товары КАК итWMSИзменениеПараметровТовараВЯчейкахТовары
		|ГДЕ
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Ссылка = &Ссылка
		|	И итWMSИзменениеПараметровТовараВЯчейкахТовары.Ссылка.Проведен
		|СГРУППИРОВАТЬ ПО
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.СерияНоменклатуры,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Характеристика,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSИзменениеПараметровТовараВЯчейкахТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	ВЫБОР
		|		КОГДА итWMSИзменениеПараметровТовараВЯчейкахТовары.КачествоИзменения = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSИзменениеПараметровТовараВЯчейкахТовары.КачествоИзменения
		|	КОНЕЦ
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	итWMSСписаниеТовараТовары.Номенклатура,
		|	итWMSСписаниеТовараТовары.СерияНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSСписаниеТовараТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.новый)
		|		ИНАЧЕ итWMSСписаниеТовараТовары.Качество
		|	КОНЕЦ,
		|	итWMSСписаниеТовараТовары.Количество,
		|	итWMSСписаниеТовараТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSСписаниеТовараТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSСписаниеТовараТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSСписаниеТовараТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSСписаниеТовараТовары.Характеристика
		|ИЗ
		|	Документ.итWMSСписаниеТовара.Товары КАК итWMSСписаниеТовараТовары
		|ГДЕ
		|	итWMSСписаниеТовараТовары.Ссылка = &Ссылка
		|	И итWMSСписаниеТовараТовары.Ссылка.Проведен
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	итWMSНаборкаТовары.Номенклатура,
		|	итWMSНаборкаТовары.СерияНоменклатуры,
		|	итWMSНаборкаТовары.Качество,
		|	СУММА(ВЫБОР
		|		КОГДА итWMSНаборкаТовары.ИзъятиеТовара
		|			ТОГДА итWMSНаборкаТовары.КоличествоФакт - итWMSНаборкаТовары.КоличествоИзъятия
		|		ИНАЧЕ итWMSНаборкаТовары.КоличествоФакт
		|	КОНЕЦ) КАК КоличествоФакт,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSНаборкаТовары.Характеристика
		|ИЗ
		|	Документ.итWMSНаборка.Товары КАК итWMSНаборкаТовары
		|ГДЕ
		|	итWMSНаборкаТовары.Ссылка = &Ссылка
		|	И итWMSНаборкаТовары.ФиксацияСтроки
		|	И итWMSНаборкаТовары.СостояниеЗадачи = ЗНАЧЕНИЕ(Перечисление.итWMSСостоянияЗадачТСД.Выполнена)
		|СГРУППИРОВАТЬ ПО
		|	итWMSНаборкаТовары.Номенклатура,
		|	итWMSНаборкаТовары.СерияНоменклатуры,
		|	итWMSНаборкаТовары.Качество,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаИзмеренияМест.Коэффициент,
		|	итWMSНаборкаТовары.Характеристика";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НоваяСтрока=Товары.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,ВыборкаДетальныеЗаписи);
	КонецЦикла;
	

	КонецПроцедуры
	
	
Функция ПроверкаНаНаличиеПеремещенияПоОснованию(СсылкаОснования)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПеремещениеТоваров.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ПеремещениеТоваров КАК ПеремещениеТоваров
		|ГДЕ
		|	ПеремещениеТоваров.Основание = &Основание
		|	И ПеремещениеТоваров.Проведен";
	
	Запрос.УстановитьПараметр("Основание", СсылкаОснования);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	Возврат Истина;	
	КонецЦикла;
	Возврат Ложь;
	
КонецФункции

#КонецЕсли