
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.итWMSНаборка") Тогда
		Если ДанныеЗаполнения.СтатусДокумента =Перечисления.итWMSСтатусыСкладскихДокументов.Выполнен или
			ДанныеЗаполнения.СтатусДокумента =Перечисления.итWMSСтатусыСкладскихДокументов.ВыполненСОшибкой или
			ДанныеЗаполнения.СтатусДокумента =Перечисления.итWMSСтатусыСкладскихДокументов.Завершен  Тогда 
			ЗаполнитьНаОснованииНаборки(ДанныеЗаполнения);
		иначе
			СтандартнаяОбработка=Ложь;
			Сообщить("Документ не находится в конечном статусе");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьНаОснованииНаборки(ДанныеЗаполнения)
	Организация=ДанныеЗаполнения.Организация;
	Сделка=ДанныеЗаполнения.итОснование;
	Ответственный=ПараметрыСеанса.ТекущийПользователь;
	Контрагент=ДанныеЗаполнения.Контрагент;
	Склад=ДанныеЗаполнения.Склад;
	Основание=ДанныеЗаполнения;
	итКоличествоВозвратнойТары=КоличествоSSCCВНаборке(ДанныеЗаполнения);
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSНаборкаТовары.Номенклатура КАК Номенклатура,
		|	итWMSНаборкаТовары.СерияНоменклатуры КАК СерияНоменклатуры,
		|	итWMSНаборкаТовары.Характеристика КАК ХарактеристикаНоменклатуры,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаХраненияОстатков КАК ЕдиницаИзмерения,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаИзмеренияМест КАК ЕдиницаИзмеренияМест,
		|	СУММА(ВЫБОР
		|			КОГДА итWMSНаборкаТовары.ИзъятиеТовара
		|				ТОГДА итWMSНаборкаТовары.КоличествоФакт - итWMSНаборкаТовары.КоличествоИзъятия
		|			ИНАЧЕ итWMSНаборкаТовары.КоличествоФакт
		|		КОНЕЦ) КАК Количество,
		|	итWMSНаборкаТовары.Качество КАК Качество
		|ИЗ
		|	Документ.итWMSНаборка.Товары КАК итWMSНаборкаТовары
		|ГДЕ
		|	итWMSНаборкаТовары.Ссылка = &Ссылка
		|	И итWMSНаборкаТовары.ФиксацияСтроки
		|	И итWMSНаборкаТовары.СостояниеЗадачи <> ЗНАЧЕНИЕ(Перечисление.итwmsсостоянияЗадачТСД.отменена)
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSНаборкаТовары.Номенклатура,
		|	итWMSНаборкаТовары.СерияНоменклатуры,
		|	итWMSНаборкаТовары.Характеристика,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаХраненияОстатков,
		|	итWMSНаборкаТовары.Номенклатура.ЕдиницаИзмеренияМест,
		|	итWMSНаборкаТовары.Качество
		|
		|ИМЕЮЩИЕ
		|	СУММА(ВЫБОР
		|			КОГДА итWMSНаборкаТовары.ИзъятиеТовара
		|				ТОГДА итWMSНаборкаТовары.КоличествоФакт - итWMSНаборкаТовары.КоличествоИзъятия
		|			ИНАЧЕ итWMSНаборкаТовары.КоличествоФакт
		|		КОНЕЦ) > 0";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Товары.Очистить();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	НоваяСтрока=Товары.Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтрока,ВыборкаДетальныеЗаписи);
	КонецЦикла;
	

КонецПроцедуры

Функция КоличествоSSCCВНаборке(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSНаборкаТовары.Ссылка КАК Ссылка,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ итWMSНаборкаТовары.ИдентификаторУпаковкиПолучатель) КАК ИдентификаторУпаковкиПолучатель
		|ИЗ
		|	Документ.итWMSНаборка.Товары КАК итWMSНаборкаТовары
		|ГДЕ
		|	итWMSНаборкаТовары.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSНаборкаТовары.Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат  ВыборкаДетальныеЗаписи.ИдентификаторУпаковкиПолучатель;
	КонецЦикла;
	
	Возврат 0;

	КонецФункции
Процедура  ПроверкаНаКоличествоОснований(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	РеализацияТоваровУслуг.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	РеализацияТоваровУслуг.Основание = &Основание
		|	И РеализацияТоваровУслуг.Ссылка <> &Ссылка
		|	И НЕ РеализацияТоваровУслуг.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Основание", Основание);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Отказ=Истина;
		Сообщить("Уже имеется не помеченная на удаление реализация");
	КонецЦикла;
	


	КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	Если ТипЗнч(Основание)=Тип("ДокументСсылка.итWMSНаборка") и не ПометкаУдаления Тогда 
		ПроверкаНаКоличествоОснований(Отказ);
	КонецЕсли;
КонецПроцедуры
