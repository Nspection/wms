#Если Сервер Тогда
	
Процедура ПередЗаписью(Отказ)
	Если УникальныйИдентификаторСерии="" Тогда
		УникальныйИдентификаторСерии=СтрЗаменить(Строка(новый УникальныйИдентификатор),"-","");
	КонецЕсли;
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
КонецПроцедуры

#КонецЕсли

Процедура ПриКопировании(ОбъектКопирования)
	УникальныйИдентификаторСерии="";
КонецПроцедуры
