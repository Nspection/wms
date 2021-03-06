
Процедура ПередЗаписью(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	ПользовательИБДанные=ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ПользовательИБ);
	Если ПользовательИБДанные=Неопределено Тогда 
		НовыйПользователь=ПользователиИнформационнойБазы.СоздатьПользователя();
		НовыйПользователь.Имя=Наименование;
		НовыйПользователь.Записать();
		ПользовательИБ=НовыйПользователь.УникальныйИдентификатор;
	КонецЕсли;
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	ПользовательИБДанные=ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ПользовательИБ);
	Если ПользовательИБДанные.Имя="" Тогда 
		Возврат
	КонецЕсли;	
	Если ДвухФакторнаяАвторизация Тогда 
		//Шаблон=ШаблоныНастроекВторогоФактораАутентификации.НайтиПоИмени("АутинтефикацияПоПочте");
		//Шаблон.Удалить();
		Шаблон=ШаблоныНастроекВторогоФактораАутентификации.НайтиПоИмени("АутинтефикацияПоПочте");
		Если Шаблон=Неопределено Тогда 
			СтрокаАвторизации = ПолучитьBase64СтрокуИзДвоичныхДанных(
			ПолучитьДвоичныеДанныеИзСтроки(
			""+"webserv"+":"+"111",КодировкаТекста.UTF8,Ложь));
			ЗапросВторогоФактора = Новый HTTPЗапрос;
			ЗапросВторогоФактора.АдресРесурса = "&host";
			ЗапросВторогоФактора.УстановитьТелоИзСтроки("Код доступа:&secret;Пользователь:&users", КодировкаТекста.UTF8);
			ЗапросВторогоФактора.Заголовки.Вставить("Content-Type", "text/plain; charset=UTF-8");
			ЗапросВторогоФактора.Заголовки.Вставить("Authorization", "Basic "+СтрокаАвторизации);
			Шаблон=ШаблоныНастроекВторогоФактораАутентификации.СоздатьШаблон();
			Шаблон.HTTPЗапросНаАутентификацию = ЗапросВторогоФактора;
			Шаблон.МетодHTTPЗапросаНаАутентификацию ="POST";
			Шаблон.Имя="АутинтефикацияПоПочте";
			Шаблон.Записать();
		КонецЕсли;
		НастройкаВторогоФактора = Новый НастройкаВторогоФактораАутентификации;
        НастройкаВторогоФактора.ИмяШаблонаНастройки = "АутинтефикацияПоПочте";
		ПараметрыЗапроса = Новый Соответствие;                   
        ПараметрыЗапроса.Вставить("host", Константы.АдресПубликацииДвухфакторнойАвторизации.Получить());
        ПараметрыЗапроса.Вставить("users", Строка(Ссылка.УникальныйИдентификатор()));
        НастройкаВторогоФактора.Параметры = ПараметрыЗапроса;
		МассивНастроек = Новый Массив;
        МассивНастроек.Добавить(НастройкаВторогоФактора);
		ПользовательИБДанные=ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ПользовательИБ);
		ПользовательИБДанные.НастройкиВторогоФактораАутентификации = МассивНастроек;
		ПользовательИБДанные.ОбработкаНастроекВторогоФактораАутентификации = ТипОбработкиНастроекВторогоФактораАутентификации.ИспользоватьСледующуюПриОшибке;
		ПользовательИБДанные.Записать();
	иначе
		ПользовательИБДанные=ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ПользовательИБ);
		ПользовательИБДанные.НастройкиВторогоФактораАутентификации=новый Массив;
		ПользовательИБДанные.ОбработкаНастроекВторогоФактораАутентификации= ТипОбработкиНастроекВторогоФактораАутентификации.НеИспользовать;
		ПользовательИБДанные.Записать();
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	ПользовательИБ=новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000");
КонецПроцедуры


