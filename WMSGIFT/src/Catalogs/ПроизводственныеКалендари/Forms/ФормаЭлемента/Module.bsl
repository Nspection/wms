&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Год=Год(ТекущаяДатаСеанса());
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДанныеКалендаря(Команда)
	Если Параметры.Ключ.Пустая() Тогда 
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("для заполнения данных каледаря, необходимо его записать");
		Возврат;
	КонецЕсли;	
	ПолучитьДанныеКалендаряНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПолучитьДанныеКалендаряНаСервере()
	Если Год=0 Тогда
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("Заполните год");
		Возврат;
	КонецЕсли;
	СервисПолученияДанных=Объект.СервисПолученияДанных;
	Если Объект.СервисПолученияДанных.ПроизвольныйСервис Тогда
		СтрокаСоединения=СервисПолученияДанных.ПроизвольнаяСтрокаПодключения;
	иначе
		СтрокаСоединения=СервисПолученияДанных.IPАдресСервера+"/"+СервисПолученияДанных.ИмяПубликацииБазы;
	КонецЕсли;
	
	Порт=?(СервисПолученияДанных.ПортHttpСервиса=0,Неопределено,СервисПолученияДанных.ПортHttpСервиса);
	Если СервисПолученияДанных.ТребуетсяАутентификация Тогда
   	HttpСоединение=новый HTTPСоединение(СтрокаСоединения,Порт,СервисПолученияДанных.Логин,СервисПолученияДанных.Пароль);
	иначе
	HttpСоединение=новый HTTPСоединение(СтрокаСоединения,Порт);	
	КонецЕсли;
	ДанныеАвторизации=Base64Строка(ПолучитьДвоичныеДанныеИзСтроки("webserv:111"));
	Запрос = Новый HTTPЗапрос("/hs/"+СервисПолученияДанных.URLПространствоСервиса+"/"+СервисПолученияДанных.ИмяОперации+"/"+СтрЗаменить(Строка(Год),Символы.НПП,""));
	Запрос.Заголовки.Вставить("Authorization","Basic "+ДанныеАвторизации);
	Результат=HttpСоединение.Получить(Запрос);
	Данные=Результат.ПолучитьТелоКакСтроку();
	ТаблицаКалендаря=итWMSСлужебныеПроцедурыИФункции.ДесериализаторДанных(Данные);
	Для Каждого стр из ТаблицаКалендаря Цикл 
	МенеджерЗаписи=РегистрыСведений.ДанныеПроизводственногоКалендаря.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Дата=стр.ДатаКалендаря;
	МенеджерЗаписи.Год=стр.год;
	МенеджерЗаписи.ПроизводственныйКалендарь=Объект.Ссылка;
	МенеджерЗаписи.Прочитать();
	МенеджерЗаписи.Дата=стр.ДатаКалендаря;
	МенеджерЗаписи.Год=стр.год;
	МенеджерЗаписи.ПроизводственныйКалендарь=Объект.Ссылка;
    МенеджерЗаписи.ВидДня=стр.ВидДня;
	МенеджерЗаписи.Записать();
	КонецЦикла;
КонецПроцедуры



