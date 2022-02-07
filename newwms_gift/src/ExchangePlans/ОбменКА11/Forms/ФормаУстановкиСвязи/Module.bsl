
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	IPАдресСервера=Параметры.IPАдресСервера;
	URLПространствоВебСервиса=Параметры.URLПространствоВебСервиса;
	ИмяПубликацииБазы=Параметры.ИмяПубликацииБазы;
    СсылкаНаУзел=Параметры.Ссылка;
	Определение=новый WSОпределения(СформироватьСтрокуПодключения() ,"webserv","111");
    ПараметрыПрокиСервера=СформироватьПараметрыПроксиСервера();
    Прокси = новый WSПрокси(Определение,ПараметрыПрокиСервера.URLПространствоИменСервиса,ПараметрыПрокиСервера.ИмяСервиса,ПараметрыПрокиСервера.ИмяТочкиПодключения);
    Прокси.Пользователь="webserv";
    Прокси.Пароль="111";
    Ответ=ДесериализаторДанных(Прокси.GetListExchange());
	Если ТипЗнч(Ответ)<>Тип("Соответствие") Тогда 
		Отказ=Истина;
		Сообщить("Что то пошло не так");
		Возврат
	КонецЕсли;
	Для Каждого Элем из Ответ Цикл 
		НоваяСтрокаДереваПланОбмена=ДеревоДанных.ПолучитьЭлементы().Добавить();
		НоваяСтрокаДереваПланОбмена.ИмяПланаОбмена=Элем.Ключ;
		Для Каждого стр из Элем.Значение Цикл 
			НоваяСтрокаДереваУзел=НоваяСтрокаДереваПланОбмена.ПолучитьЭлементы().Добавить();
			НоваяСтрокаДереваУзел.ИмяПланаОбмена=Элем.Ключ;
			НоваяСтрокаДереваУзел.ИмяУзла=стр.Имя;
			НоваяСтрокаДереваУзел.Ссылка=стр.Ссылка;
            НоваяСтрокаДереваУзел.Тип=стр.Тип;
         КонецЦикла;
	КонецЦикла;
КонецПроцедуры

#Область КонвертацияДанных
&НаСервере
Функция ДесериализаторДанных(Данные)Экспорт 
	ЧтениеданныхXML=новый ЧтениеXML;
	ЧтениеданныхXML.УстановитьСтроку(Данные);
	Данные= СериализаторXDTO.ПрочитатьXML(ЧтениеданныхXML);
	ЧтениеданныхXML.Закрыть();
	Возврат Данные;
КонецФункции
&НаСервере
Функция  СериализаторДанных(Данные)Экспорт
	ДеревоДанныхXDTO=СериализаторXDTO.ЗаписатьXDTO(Данные);
	ЗаписьXML=новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку();
	ФабрикаXDTO.ЗаписатьXML(ЗаписьXML,ДеревоДанныхXDTO);
	Возврат ЗаписьXML.Закрыть();
КонецФункции
#КонецОбласти

#Область ФормированиеПараметровПодключенияWeb
&НаСервере
Функция СформироватьСтрокуПодключения()  
	ПараметрыДанных=СформироватьПараметрыПодключения();
	IPАдресСервера=ПараметрыДанных.IPАдресСервера;
	ИмяПубликацииБазы=ПараметрыДанных.ИмяПубликацииБазы;
	URLПространствоВебСервиса=ПараметрыДанных.URLПространствоВебСервиса;	
	СтрокаWSОпределения = "http://"+СокрЛП(IPАдресСервера)+"/"+СокрЛП(ИмяПубликацииБазы)+"/ws/"+СокрЛП(URLПространствоВебСервиса)+".1cws?wsdl";
	Возврат СтрокаWSОпределения;
КонецФункции
&НаСервере
Функция СформироватьПараметрыПодключения()
	IPАдресСервера=СокрЛП(IPАдресСервера);
	ИмяПубликацииБазы=СокрЛП(ИмяПубликацииБазы);
	URLПространствоВебСервиса=СокрЛП(URLПространствоВебСервиса);
	Структура=новый Структура("IPАдресСервера,ИмяПубликацииБазы,URLПространствоВебСервиса",IPАдресСервера,ИмяПубликацииБазы,URLПространствоВебСервиса);
	Возврат Структура
КонецФункции
&НаСервере
Функция СформироватьПараметрыПроксиСервера()  
	URLПространствоВебСервиса=URLПространствоВебСервиса;
	Структура=новый Структура;
	Структура.Вставить("URLПространствоИменСервиса",СокрЛП(URLПространствоВебСервиса));
	Структура.Вставить("ИмяСервиса",СокрЛП(URLПространствоВебСервиса));
	Структура.Вставить("ИмяТочкиПодключения",СокрЛП(URLПространствоВебСервиса)+"Soap");
	
	Возврат Структура
КонецФункции


&НаКлиенте
Процедура ДеревоДанныхВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтруктураДанных=новый Структура;
	СтруктураДанных.Вставить("ИмяПланаОбмена",ТекущийЭлемент.ТекущиеДанные.ИмяПланаОбмена);
	СтруктураДанных.Вставить("ИмяУзла",ТекущийЭлемент.ТекущиеДанные.ИмяУзла);
	СтруктураДанных.Вставить("Ссылка",ТекущийЭлемент.ТекущиеДанные.Ссылка);
	СтруктураДанных.Вставить("Тип",ТекущийЭлемент.ТекущиеДанные.Тип);
    ОповеститьОВыборе(СтруктураДанных);
КонецПроцедуры
#КонецОбласти
