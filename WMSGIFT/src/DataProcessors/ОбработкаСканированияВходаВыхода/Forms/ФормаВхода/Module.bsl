
&НаКлиенте
Процедура ПриОткрытии(Отказ)
   ПоддерживаемыеТипыВО = Новый Массив();
   ПоддерживаемыеТипыВО.Добавить("СканерШтрихкода");
   ОповещенияПриПодключении = Новый ОписаниеОповещения("ПодключитьОборудованиеЗавершение", ЭтотОбъект); 
   МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПоТипу(ОповещенияПриПодключении, УникальныйИдентификатор, ПоддерживаемыеТипыВО);
КонецПроцедуры
&НаКлиенте
Процедура ПодключитьОборудованиеЗавершение(РезультатВыполнения, Параметры) Экспорт
 
   Если Не РезультатВыполнения.Результат Тогда
      ТекстСообщения = НСтр( "ru = 'При подключении оборудования произошла ошибка:""%ОписаниеОшибки%"".'");
      ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%" , РезультатВыполнения.ОписаниеОшибки);
      Сообщить(ТекстСообщения);
   Иначе
      ТекстСообщения = НСтр("ru = 'Оборудование подключено.'" );
      Сообщить(ТекстСообщения);
   КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если Источник = "ПодключаемоеОборудование" Тогда
		Если ИмяСобытия = "ScanData" Тогда // Данные приходят в виде строки
			ТекКод = Параметр[0];
			ОбработатьПолученныйШК(ТекКод);
		ИначеЕсли ИмяСобытия = "ScanDataBase64" Тогда // Данные приходят закодированные в Base64 
			СимволыШтрихкодBase64 = Base64Значение(Параметр[0]); // Декодируем строку
			ОбработатьПолученныйШКBase64(СимволыШтрихкодBase64);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры
&НаКлиенте
Процедура ОбработатьПолученныйШК(ТекКод)
ОбработатьПолученныйШКНаСервере(ТекКод);	
УстановитьHTML();	
КонецПроцедуры
&НаСервере
Процедура ОбработатьПолученныйШКНаСервере(ТекКод)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ФизическиеЛица.Ссылка КАК Ссылка
		|ПОМЕСТИТЬ ВтФизЛицо
		|ИЗ
		|	Справочник.ФизическиеЛица КАК ФизическиеЛица
		|ГДЕ
		|	ФизическиеЛица.ШтрихКод = &ШтрихКод
		|	И НЕ ФизическиеЛица.ПометкаУдаления
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	итWMSРаботникиСклада.Ссылка КАК Ссылка
		|ИЗ
		|	ВтФизЛицо КАК ВтФизЛицо
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.итWMSРаботникиСклада КАК итWMSРаботникиСклада
		|		ПО ВтФизЛицо.Ссылка = итWMSРаботникиСклада.ФизическоеЛицо
		|			И (НЕ итWMSРаботникиСклада.Заблокирован
		|				И НЕ итWMSРаботникиСклада.ПометкаУдаления)";
	
	Запрос.УстановитьПараметр("ШтрихКод", ТекКод);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Дата=ТекущаяДата();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НаборЗаписей=РегистрыСведений.ДанныеВходаВыходаРаботника.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Дата.Установить(Дата);
		НаборЗаписей.Отбор.Организация.Установить(Организация);
		НаборЗаписей.Отбор.РаботникСклада.Установить(ВыборкаДетальныеЗаписи.Ссылка);
		НаборЗаписей.Прочитать();
		НаборЗаписей.Очистить();
		НаборЗаписей.Записать();
		НоваяЗапись=НаборЗаписей.Добавить();
		НоваяЗапись.Дата=Дата;
		НоваяЗапись.Организация=Организация;
		НоваяЗапись.РаботникСклада=ВыборкаДетальныеЗаписи.Ссылка;
		НоваяЗапись.ДействиеВходаВыхода=Перечисления.ДействияВходаВыхода.Вход;
		НаборЗаписей.Записать();
        ЛогСканированияТекстовыйДокумент.ДобавитьСтроку("Вход "+ВыборкаДетальныеЗаписи.Ссылка+ " "+Строка(Дата));
	КонецЦикла;
	
	
	КонецПроцедуры
&НаСервере
Функция ВозвратЦветаHTML(ВебЦвет)
	Если ВебЦвет=WebЦвета.Черный Тогда 
		Возврат """"+"Black"+"""";
	ИначеЕсли ВебЦвет=WebЦвета.Красный Тогда 
		Возврат  """"+"red"+"""";
	ИначеЕсли ВебЦвет= WebЦвета.Древесный Тогда 
		Возврат """"+"Peru"+"""";
	ИначеЕсли ВебЦвет= WebЦвета.Синий Тогда 
		Возврат """"+"Blue"+"""";
	ИначеЕсли ВебЦвет= WebЦвета.Фиолетовый Тогда 
        Возврат """"+"Purple"+"""";
	Иначе 
		Возврат """"+"Black"+"""";
	КонецЕсли;
КонецФункции
&НаСервере
Функция УстановитьHTML()
	Данные="";
	СтрокВДокументе=ЛогСканированияТекстовыйДокумент.КоличествоСтрок();
	НачальнаяПозиция=1;
	Если  СтрокВДокументе>5 Тогда 
		НачальнаяПозиция=СтрокВДокументе-5;
	КонецЕсли;
	
	для n=НачальнаяПозиция по СтрокВДокументе Цикл  
		Данные=Данные+"<p>"+"<font color="+ВозвратЦветаHTML(WebЦвета.Синий)+">"+ЛогСканированияТекстовыйДокумент.ПолучитьСтроку(n) +"</font>"+"</p><BR>";
	КонецЦикла;
	
	
	ЛогСканированияHTML="<!DOCTYPE HTML>
	|<html>
	|<body>
	|"+ЗаголовокHTML();
	ЛогСканированияHTML=ЛогСканированияHTML+Данные;
	ЛогСканированияHTML=ЛогСканированияHTML+"
	|</body>
	|</html>";
	КонецФункции
&НаСервере
Функция ЗаголовокHTML()
	Макет=Обработки.ит_WMS_ОбработчикРозницы.ПолучитьМакет("Макет");
	Возврат Макет.Области.ЗаголовокHTML.Текст;
КонецФункции

&НаКлиенте
Процедура ОбработатьПолученныйШКBase64(СимволыШтрихкодBase64)
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(Отказ)
   
   ПоддерживаемыеТипыВО = Новый Массив();
   ПоддерживаемыеТипыВО.Добавить("СканерШтрихкода");
   ОповещенияПриПодключении = Новый ОписаниеОповещения("ОтключитьОборудованиеЗавершение", ЭтотОбъект); 
   МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПоТипу(ОповещенияПриПодключении, УникальныйИдентификатор, ПоддерживаемыеТипыВО);

КонецПроцедуры

&НаКлиенте
Процедура ОтключитьОборудованиеЗавершение(РезультатВыполнения, Параметры) Экспорт
   
   Если Не РезультатВыполнения.Результат Тогда
      ТекстСообщения = НСтр( "ru = 'При отключении оборудования произошла ошибка: ""%ОписаниеОшибки%"".'");
      ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%" , РезультатВыполнения.ОписаниеОшибки);
      Сообщить(ТекстСообщения);
   Иначе
      ТекстСообщения = НСтр("ru = 'Оборудование отключено.'" );
      Сообщить(ТекстСообщения);
   КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбщегоНазначения.УстановитьОрганизациюВДокументе(ЭтаФорма);
КонецПроцедуры
