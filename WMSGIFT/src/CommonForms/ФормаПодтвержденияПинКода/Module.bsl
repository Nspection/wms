
&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если не ЗавершениеРаботы Тогда 
	Отказ=ПинкодПодтвержден();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
СформироватьНовыйПинкод();
КонецПроцедуры

&НаСервере
Процедура СформироватьНовыйПинкод()
	Генератор=	новый ГенераторСлучайныхЧисел();
    ПинкодСеанса=ПинкодСеанса+Строка(Генератор.СлучайноеЧисло(0,9));
    ПинкодСеанса=ПинкодСеанса+Строка(Генератор.СлучайноеЧисло(0,9));
    ПинкодСеанса=ПинкодСеанса+Строка(Генератор.СлучайноеЧисло(0,9));
    ПинкодСеанса=ПинкодСеанса+Строка(Генератор.СлучайноеЧисло(0,9));
    ДатаФормированияПинкода=ТекущаяДата();
КонецПроцедуры


&НаСервере
Функция  ПинкодПодтвержден();
	Если Пинкод=ПинкодСеанса Тогда 
		Возврат Ложь;
	иначе
		Возврат Истина;
	КонецЕсли;	
	КонецФункции