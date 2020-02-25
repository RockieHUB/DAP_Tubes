program tubesfinal;
uses crt,math;

const nMax = 13;

type baju = record
	model : string;
	bahan : string;
	jumlah : integer;
	harga : longint;
end;

type customer = record
	nama : string;
	tipe : array[1..3] of baju;
	total : longint;
	ID_Number : integer;
end;

type ID_Customer = array[1..nMax] of customer;

var
	IDC : ID_Customer;
	duplikat : ID_Customer;
	counter , submenu : char;
	menu : integer;
	N , i_main : integer;

//Procedure CopyArray
	procedure Salin(Data : ID_Customer ;var copy : ID_Customer);
	var	
		i : integer;
	begin
		for i := 1 to N do
			copy[i]:= Data[i];
	end;
	
//CARA HITUNGNYA	
	procedure hitungtotal(i,j : integer; var Data : ID_Customer);
	var	
		banyak : longint;
		jumbahan , jumjahit: longint;
	begin
		case Data[i].tipe[j].model of
			'Gamis' : 	begin
							banyak := ceil(3.5 * Data[i].tipe[j].jumlah);
							if (Data[i].tipe[j].bahan = 'Jeans')then
								jumbahan := banyak * 100000
							else
								jumbahan := banyak * 70000;
							jumjahit := Data[i].tipe[j].jumlah * 100000;
							Data[i].tipe[j].harga := jumbahan + jumjahit;
						end;
					
			'Celana Panjang Kulot': begin
										banyak := ceil(2 * Data[i].tipe[j].jumlah);
										if (Data[i].tipe[j].bahan = 'Jeans')then
											jumbahan := banyak * 100000
										else
											jumbahan := banyak * 70000;
										jumjahit := Data[i].tipe[j].jumlah * 75000;
										Data[i].tipe[j].harga := jumbahan + jumjahit;
									end;
			'Kemeja Tunik':	begin
								banyak := ceil(2.2 * Data[i].tipe[j].jumlah);
								if (Data[i].tipe[j].bahan = 'Jeans')then
									jumbahan := banyak * 100000
								else
									jumbahan := banyak * 70000;
								jumjahit := Data[i].tipe[j].jumlah * 60000;
								Data[i].tipe[j].harga := jumbahan + jumjahit;
							end;
			'Rok Panjang': 	begin
								banyak := round(3 * Data[i].tipe[j].jumlah);
								if (Data[i].tipe[j].bahan = 'Jeans')then
									jumbahan := banyak * 100000
								else
									jumbahan := banyak * 70000;
								jumjahit := Data[i].tipe[j].jumlah * 40000;
								Data[i].tipe[j].harga := jumbahan + jumjahit;
							end;				
		end;
	end;
	
//fungsi cari nama
	function SearchNama(Data : ID_Customer ; x : string):integer;
	{I.S tersedia data customer dan nama yang akan dicari
	 F.S mengembalikan posisi array nama atau mengembalikan 0
	 jika nama tidak ditemukan}
	var
		i_nama : integer;
	begin
		i_nama := 1;
		while ((i_nama <= N) and not(Data[i_nama].nama = x )) do
			i_nama := i_nama + 1;
		if Data[i_nama].nama = x then
			SearchNama := i_nama
		else
			SearchNama := 0;
	end;

//fungsi cari baju di dalam customer
	function SearchBaju(Data : Customer ; x : string):boolean;
	{I.S tersedia data customer dan nama yang akan dicari
	 F.S mengembalikan posisi array nama atau mengembalikan 0
	 jika nama tidak ditemukan}
	var
		i_model : integer;
	begin
		i_model := 1;
		repeat		
			while ((i_model <= 2) and not(Data.tipe[i_model].model = x)) do
				i_model := i_model + 1;
			if Data.tipe[i_model].model = x then
				SearchBaju := true
			else
				SearchBaju := false;
		until((Data.tipe[i_model].model = x) or (i_model > 2));
	end;

//Pengurutan(insertion) ke Besar
	procedure UrutKeAtas(var data : ID_Customer);
	{I.S : Menerima Data customer
	 F.S : Mengurutkan berdasarkan total harga}
	var
		i , j : integer;
		y : customer;
		found : boolean;
	begin
		
		for i := 2 to N do
			begin
				y := Data[i];
				j := i - 1;
				found := false;
				while ((j >= 1) and not(found)) do
					begin
						if (y.total < Data[j].total) then
							begin
								Data[j + 1] := Data[j];
								j := j - 1;
							end
						else
							found := true;
					end;
				Data[j+1] := y;
			end;
	end;
	
//Pengurutan(insertion) ke Kecil
	procedure UrutKeBawah(var data : ID_Customer);
	{I.S : Menerima Data customer
	 F.S : Mengurutkan berdasarkan total harga}
	var
		i , j : integer;
		y : customer;
		found : boolean;
	begin
		for i := 2 to N do
			begin
				y := Data[i];
				j := i - 1;
				found := false;
				while ((j >= 1) and not(found)) do
					begin
						if (y.total > Data[j].total) then
							begin
								Data[j + 1] := Data[j];
								j := j - 1;
							end
						else
							found := true;
					end;
				Data[j+1] := y;
			end;
	end;

//MAIN PROCEDURE
//ISI ARRAY (1)
	procedure Create_Array(var Data : ID_Customer);
	var
		j : integer;
		counter1 , counter2: char;
		modelI , bahanI , jumlahI: integer;
		ch : char;
	begin
		writeln;
		repeat
			i_main := i_main + 1;
			j := 1;
			Data[i_main].ID_Number := i_main;
			writeln('FORM PEMESANAN BAJU');
			writeln('ID_Customer          : ',Data[i_main].ID_Number);
			write('Nama                 : ');
			readln(Data[i_main].nama);
			repeat
				writeln('Jenis Model Pakaian');
				writeln('1. Gamis');
				writeln('2. Celana Panjang Kulot');
				writeln('3. Kemeja Tunik');
				writeln('4. Rok Panjang');
				write('Pilihan anda         : '); readln(modelI);
				while ((modelI < 1) or (modelI > 4)) do
					begin
						write('Maaf , input salah. masukkan ulang : ');
						readln(modelI);
					end;
				case modelI of
				1 :	Data[i_main].tipe[j].model := 'Gamis';
				2 : Data[i_main].tipe[j].model := 'Celana Panjang Kulot';
				3 : Data[i_main].tipe[j].model := 'Kemeja Tunik';
				4 : Data[i_main].tipe[j].model := 'Rok Panjang';
				end;
				writeln('Tipe Bahan untuk model Pakaian : ');
				writeln('1.Jeans');
				writeln('2.Katun');
				write('Pilihan anda         : ');
				readln(bahanI);
				while ((bahanI < 1) or (bahanI > 2)) do
					begin
						write('Maaf , input salah. masukkan ulang : ');
						readln(bahanI);
					end;
				if (bahanI = 1) then
					Data[i_main].tipe[j].bahan := 'Jeans'
				else
					Data[i_main].tipe[j].bahan := 'Katun';
				write('Berapa Banyak?       : ');
				readln(jumlahI);
				while (jumlahI < 1) do
					begin
						write('Maaf , input salah. masukkan ulang : ');
						readln(jumlahI);
					end;
				Data[i_main].tipe[j].jumlah := jumlahI;
				hitungtotal(i_main,j,Data);
				if j <> 2 then
				begin
					repeat
						write('Apakah Anda Ingin Model Lain?[y/t] (maksimal 2 pesanan/customer) : ');
						readln(counter2);
					until ((counter2 = 'y') or (counter2 = 't'));
				end;
				j := j + 1;
			until ((counter2 = 't') or (j > 2));
			Data[i_main].total := Data[i_main].tipe[1].harga + Data[i_main].tipe[2].harga;
			N := N + 1;
			repeat
			write('Input untuk customer lain? [y/t] : ');
			readln(counter1);
			until ((counter1 ='y') or (counter1 = 't'));
			writeln;
		until (counter1 = 't');
		writeln('Press any key to continue');
		ch := readkey;
	end;

//OUTPUT ARRAY (2)
	procedure Baca_Data(Data : ID_Customer);
	var
		i , menu_read1, menu_read2 : integer;
		x : string;
		ch : char;
		pos : integer;
		jum : integer;
	begin
		writeln;
		Salin(Data,duplikat);
		writeln('|==============================|');
		writeln('|             MENU             |');
		writeln('|1. Semua                      |');
		writeln('|2. Terurut ke Besar           |');
		writeln('|3. Terurut ke Kecil           |');
		writeln('|4. Cari Nama                  |');
		writeln('|==============================|');
		write('Pilihan Anda : ');
		readln(menu_read1);
		writeln;
		case menu_read1 of
			1 :	begin
					writeln('|==============================|');
					writeln('|             MENU             |');
					writeln('|1. Array                      |');
					writeln('|2. Gamis                      |');
					writeln('|3. Celana Panjang Kulot       |');
					writeln('|4. Kemeja Tunik               |');
					writeln('|5. Rok Panjang                |');
					writeln('|==============================|');
					write('Pilihan Anda : ');
					readln(menu_read2);
					writeln;
					case menu_read2 of
					1 :	begin
							for i := 1 to N do
								begin
									writeln('ID_Customer           : ',Data[i].ID_Number);
									writeln('Nama                  : ',Data[i].nama);
									writeln('Pesanan ');
									writeln('  ',Data[i].tipe[1].model,' ',Data[i].tipe[1].jumlah,' Buah');
									if (Data[i].tipe[2].jumlah <> 0) then
										writeln('  ',Data[i].tipe[2].model,' ',Data[i].tipe[2].jumlah,' Buah');
									writeln('Biaya                 : Rp',Data[i].total);
									writeln;
								end;
							writeln('Press any key to continue');
							ch := readkey;
						end;
					2 : begin
							jum := 0;
							for i := 1 to N do
								begin
									if( SearchBaju(Data[i] , 'Gamis') ) then
									begin
										writeln('ID_Customer          : ',Data[i].ID_Number);
										writeln('Nama                 : ',Data[i].nama);
										writeln('Pesanan ');
										writeln('  ',Data[i].tipe[1].model,' ',Data[i].tipe[1].jumlah,' Buah');
										if (Data[i].tipe[2].jumlah <> 0) then
											writeln('  ',Data[i].tipe[2].model,' ',Data[i].tipe[2].jumlah,' Buah');
										writeln('Biaya                : Rp',Data[i].total);
										jum := jum + Data[i].tipe[1].jumlah;
										writeln;
									end
									else
										writeln('Maaf , nama yang anda cari tidak ada');
								end;
							writeln('Banyak Gamis : ',jum);
							writeln('Press any key to continue');
							ch := readkey;
						end;
					3 :	begin
							for i := 1 to N do
								begin
									if( SearchBaju(Data[i] , 'Celana Panjang Kulot') ) then
									begin
										writeln('ID_Customer          : ',Data[i].ID_Number);
										writeln('Nama                 : ',Data[i].nama);
										writeln('Pesanan ');
										writeln('  ',Data[i].tipe[1].model,' ',Data[i].tipe[1].jumlah,' Buah');
										if (Data[i].tipe[2].jumlah <> 0) then
											writeln('  ',Data[i].tipe[2].model,' ',Data[i].tipe[2].jumlah,' Buah');
										writeln('Biaya                : Rp',Data[i].total);
										writeln;
									end
									else
										writeln('Maaf , nama yang anda cari tidak ada');
								end;
							writeln('Press any key to continue');
							ch := readkey;
						end;
					4 :	begin
							for i := 1 to N do
								begin
									if( SearchBaju(Data[i] , 'Kemeja Tunik') ) then
									begin
										writeln('ID_Customer          : ',Data[i].ID_Number);
										writeln('Nama                 : ',Data[i].nama);
										writeln('Pesanan ');
										writeln('  ',Data[i].tipe[1].model,' ',Data[i].tipe[1].jumlah,' Buah');
										if (Data[i].tipe[2].jumlah <> 0) then
											writeln('  ',Data[i].tipe[2].model,' ',Data[i].tipe[2].jumlah,' Buah');
										writeln('Biaya                : Rp',Data[i].total);
										writeln;
									end
									else
										writeln('Maaf , nama yang anda cari tidak ada');
								end;
							writeln('Press any key to continue');
							ch := readkey;
						end;
					5 : begin
							for i := 1 to N do
								begin
									if( SearchBaju(Data[i] , 'Rok Panjang') ) then
									begin
										writeln('ID_Customer          : ',Data[i].ID_Number);
										writeln('Nama                 : ',Data[i].nama);
										writeln('Pesanan ');
										writeln('  ',Data[i].tipe[1].model,' ',Data[i].tipe[1].jumlah,' Buah');
										if (Data[i].tipe[2].jumlah <> 0) then
											writeln('  ',Data[i].tipe[2].model,' ',Data[i].tipe[2].jumlah,' Buah');
										writeln('Biaya                : Rp',Data[i].total);
										writeln;
									end
									else
										writeln('Maaf , nama yang anda cari tidak ada');
								end;
							writeln('Press any key to continue');
							ch := readkey;
						end;
					end;
				end;
			2 :	begin
					UrutKeAtas(duplikat);
					for i := 1 to N do
						begin
							writeln('ID_Customer          : ',duplikat[i].ID_Number);
							writeln('Nama                 : ',duplikat[i].nama);
							writeln('Pesanan ');
							writeln('  ',duplikat[i].tipe[1].model,' ',duplikat[i].tipe[1].jumlah,' Buah');
							if (duplikat[i].tipe[2].jumlah <> 0) then
								writeln('  ',duplikat[i].tipe[2].model,' ',duplikat[i].tipe[2].jumlah,' Buah');
							writeln('Biaya                : Rp',duplikat[i].total);
							writeln;
						end;
					writeln('Press any key to continue');
					ch := readkey;
				end;
			3 :	begin
					UrutKeBawah(duplikat);
					for i := 1 to N do
						begin
							writeln('ID_Customer          : ',duplikat[i].ID_Number);
							writeln('Nama                 : ',duplikat[i].nama);
							writeln('Pesanan ');
							writeln('  ',duplikat[i].tipe[1].model,' ',duplikat[i].tipe[1].jumlah,' Buah');
							if (duplikat[i].tipe[2].jumlah <> 0) then
								writeln('  ',duplikat[i].tipe[2].model,' ',duplikat[i].tipe[2].jumlah,' Buah');
							writeln('Biaya                : Rp',duplikat[i].total);
							writeln;
						end;
					writeln('Press any key to continue');
					ch := readkey;
				end;
			4 :	begin
					write('Nama yang dicari     : ');
					readln(x);
					pos := SearchNama(Data,x);
					if (pos <> 0) then
					begin
						writeln('ID_Customer          : ',Data[pos].ID_Number);
						writeln('Pesanan ');
						writeln('  ',Data[pos].tipe[1].model,' ',Data[pos].tipe[1].jumlah,' Buah');
						if (Data[pos].tipe[2].jumlah <> 0) then
							writeln('  ',Data[pos].tipe[2].model,' ',Data[pos].tipe[2].jumlah,' Buah');
						writeln('Biaya                : Rp',Data[pos].total);
					end
					else
						begin
						writeln('Maaf , nama yang anda cari tidak ada');
						writeln;
						end;;
					writeln('Press any key to continue');
					ch := readkey;	
				end;
		end;
	end;

//Update DATA (3)
	procedure Update_Data(var Data : ID_Customer);
	var
		x : string;
		pos : integer;
		j : integer;
		counter1 , counter2: char;
		modelI , bahanI , jumlahI: integer;
		ch : char;
	begin
		writeln;
		repeat
			j := 1;
			write('Nama yang diperbarui : ');
			readln(x);
			pos := SearchNama(Data,x);
			if (pos <> 0) then
				begin
					writeln('ID_Customer          : ',Data[pos].ID_Number);
					write('Nama                 : ');
					readln(Data[i_main].nama);
					repeat
						writeln('Jenis Model Pakaian');
						writeln('1. Gamis');
						writeln('2. Celana Panjang Kulot');
						writeln('3. Kemeja Tunik');
						writeln('4. Rok Panjang');
						write('Pilihan anda :       '); readln(modelI);
						while ((modelI < 1) or (modelI > 4)) do
							begin
								write('Maaf , input salah. masukkan ulang : ');
								readln(modelI);
							end;
						case modelI of
						1 :	Data[pos].tipe[j].model := 'Gamis';
						2 : Data[pos].tipe[j].model := 'Celana Panjang Kulot';
						3 : Data[pos].tipe[j].model := 'Kemeja Tunik';
						4 : Data[pos].tipe[j].model := 'Rok Panjang';
						end;
						writeln('Tipe Bahan untuk model Pakaian : ');
						writeln('1.Jeans');
						writeln('2.Katun');
						write('Pilihan anda         : ');
						readln(bahanI);
						if (bahanI = 1) then
							Data[pos].tipe[j].bahan := 'Jeans'
						else
							Data[pos].tipe[j].bahan := 'Katun';
						write('Berapa Banyak?       : ');
						readln(jumlahI);
						while (jumlahI < 1) do
							begin
								write('Maaf , input salah. masukkan ulang : ');
								readln(jumlahI);
							end;
						Data[pos].tipe[j].Jumlah := jumlahI;
						hitungtotal(pos,j,Data);
						if j <> 2 then
						begin
							repeat
								write('Apakah Anda Ingin Model Lain?[y/t] (maksimal 2 pesanan/customer) : ');
								readln(counter2);
							until ((counter2 = 'y') or (counter2 = 't'));
						end;
						j := j + 1;
					until (counter2 = 't');
					Data[pos].total := Data[pos].tipe[1].harga + Data[pos].tipe[2].harga;
					repeat
						write('Update untuk customer lain? [y/t] : ');
						readln(counter1);
					until ((counter1 = 'y') or (counter1 = 't'));
					writeln;
				end
			else
				writeln('Maaf , nama yang anda cari tidak ada');
		until((counter1 = 't')or(pos = 0));
		writeln;
		writeln('Press any key to continue');
		ch := readkey;
	end;
	
//Delete DATA (4)
	procedure Delete_Data(var Data : ID_Customer);
	var
		i , j : integer;
		confirm : char;
	begin
		writeln;
		write('Apakah anda yakin ingin menghapus semua data[y/t]?');readln(confirm);
		if confirm = 'y' then
		begin
			for i := 1 to N do
			begin
				Data[i].nama := '-';
				Data[i].total := 0;
				for j := 1 to 2 do
				begin
					Data[i].tipe[j].model := '-';
					Data[i].tipe[j].bahan := '-';
					Data[i].tipe[j].jumlah := 0;
					Data[i].tipe[j].harga := 0;
				end;
			end;
		end;
		i_main := 0;
		N := 0;
	end;
			
//MAIN PROGRAM
begin
	i_main := 0;
	N := 0;
	repeat
		clrscr;
		writeln('|================================|');
		writeln('|SELAMAT DATANG DI BUATBAJU.telyu|');
		writeln('|================================|');
		writeln('|~ ~ ~ ~ ~ ~  MENU  ~ ~ ~ ~ ~ ~ ~|');
		writeln('|1. Isi Data Customer            |');
		writeln('|2. Tampilkan Data               |');
		writeln('|3. Update Data                  |');
		writeln('|4. Hapus Data                   |');
		writeln('|5. Keluar                       |');
		writeln('|================================|');
		write('Pilihan Anda : ');
		readln(menu);
		case menu of
			1 : Create_Array(IDC);
			2 : Baca_Data(IDC);
			3 : Update_Data(IDC);
			4 : Delete_Data(IDC);
			5 :	begin
					write('Anda yakin ingin keluar?[y/t] : ');
					readln(submenu);
				end;
		end;
	until (submenu = 'y');
end.