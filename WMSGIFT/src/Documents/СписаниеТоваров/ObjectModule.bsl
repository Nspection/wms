
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSСписаниеТовара") Тогда 
		ЗаполнениеНаОснованииСписанияWMS(ДанныеЗаполнения);
	КонецЕсли;
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSНаборка") Тогда 
		ЗаполнениеНаОснованииСписанияWMS(ДанныеЗаполнения);
	КонецЕсли;

КонецПроцедуры
	
	
Процедура ЗаполнениеНаОснованииСписанияWMS(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSНаборкаТовары.Номенклатура КАК Номенклатура,
		|	итWMSНаборкаТовары.СерияНоменклатуры КАК СерияНоменклатуры,
		|	итWMSНаборкаТовары.Характеристика КАК ХарактеристикаНоменклатуры,
		|	ВЫБОР
		|		КОГДА итWMSНаборкаТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.Новый)
		|		ИНАЧЕ итWMSНаборкаТовары.Качество
		|	КОНЕЦ КАК Качество,
		|	СУММА(ВЫБОР
		|			КОГДА итWMSНаборкаТовары.ИзъятиеТовара
		|				ТОГДА итWMSНаборкаТовары.КоличествоФакт - итWMSНаборкаТовары.КоличествоИзъятия
		|			ИНАЧЕ итWMSНаборкаТовары.КоличествоФакт
		|		КОНЕЦ) КАК Количество
		|ИЗ
		|	Документ.итWMSНаборка.Товары КАК итWMSНаборкаТовары
		|ГДЕ
		|	итWMSНаборкаТовары.Ссылка = &Ссылка
		|	И итWMSНаборкаТовары.ФиксацияСтроки
		|	И итWMSНаборкаТовары.СостояниеЗадачи <> ЗНАЧЕНИЕ(Перечисление.итWmsСостоянияЗадачТСд.Отменена)
		|	И итWMSНаборкаТовары.Ссылка.Проведен
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSНаборкаТовары.Номенклатура,
		|	итWMSНаборкаТовары.СерияНоменклатуры,
		|	итWMSНаборкаТовары.Характеристика,
		|	ВЫБОР
		|		КОГДА итWMSНаборкаТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.Новый)
		|		ИНАЧЕ итWMSНаборкаТовары.Качество
		|	КОНЕЦ
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	итWMSСписаниеТовараТовары.Номенклатура,
		|	итWMSСписаниеТовараТовары.СерияНоменклатуры,
		|	итWMSСписаниеТовараТовары.Характеристика,
		|	ВЫБОР
		|		КОГДА итWMSСписаниеТовараТовары.Качество = ЗНАЧЕНИЕ(Справочник.Качество.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.Качество.Новый)
		|		ИНАЧЕ итWMSСписаниеТовараТовары.Качество
		|	КОНЕЦ,
		|	итWMSСписаниеТовараТовары.Количество
		|ИЗ
		|	Документ.итWMSСписаниеТовара.Товары КАК итWMSСписаниеТовараТовары
		|ГДЕ
		|	итWMSСписаниеТовараТовары.Ссылка = &Ссылка
		|	И итWMSСписаниеТовараТовары.Ссылка.Проведен";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Склад=ДанныеЗаполнения.Склад;
	Организация=ДанныеЗаполнения.Организация;
	Основание=ДанныеЗаполнения;
	
	
	Товары.Очистить();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	     НоваяСтрока=Товары.Добавить();
		 ЗаполнитьЗначенияСвойств(НоваяСтрока,ВыборкаДетальныеЗаписи);
	КонецЦикла;
	


КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	Если ПроверкаНаНаличаеСписанияПоОснованию() Тогда 
		Отказ=Истина;
		Сообщить("По текущему основанию уже имеется списание");
	КонецЕсли;	
КонецПроцедуры

Функция ПроверкаНаНаличаеСписанияПоОснованию()
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СписаниеТоваров.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.СписаниеТоваров КАК СписаниеТоваров
		|ГДЕ
		|	СписаниеТоваров.Проведен
		|	И СписаниеТоваров.Основание = &Основание
		|	И СписаниеТоваров.Ссылка <> &Ссылка";
	
	Запрос.УстановитьПараметр("Основание", Основание);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);

	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат Истина;
	КонецЦикла;
	    Возврат Ложь;


	КонецФункции
