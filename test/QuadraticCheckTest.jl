include("../../Julia-Rootfinding/src/QuadraticCheck.jl")
using Test

function test_all_QuadraticCheck()
    @testset "All tests in QuadraticCheckTest.jl" begin
        test_quadraticCheck2D()
    end
end

function test_get_fixed_vars()
    @testset "get_fixed_vars unit tests" begin
        dim_1 = 1
        @test get_fixed_vars(dim_1) == []

        dim_2 = 2
        @test get_fixed_vars(dim_2) == [(1,),(2,)]

        dim_3 = 3
        @test get_fixed_vars(dim_3) == [(1, 2), (1, 3), (2, 3), (1,), (2,), (3,)]

        dim_4 = 5
        @test get_fixed_vars(dim_4) == [(1, 2, 3, 4), (1, 2, 3, 5), (1, 2, 4, 5), (1, 3, 4, 5), (2, 3, 4, 5), (1, 2, 3), (1, 2, 4), (1, 2, 5), (1, 3, 4), (1, 3, 5), (1, 4, 5), (2, 3, 4), (2, 3, 5), (2, 4, 5), (3, 4, 5), (1, 2), (1, 3), (1, 4), (1, 5), (2, 3), (2, 4), (2, 5), (3, 4), (3, 5), (4, 5), (1,), (2,), (3,), (4,), (5,)]
    end
end

function test_quadraticCheck2D()
    @testset "quadraticCheck2D unit tests" begin
        def_tol = 0.

        # ==== TRUE ====
        coeff_1 = [1.;-1;;1;-1]
        @test quadraticCheck2D(coeff_1,def_tol) == true

        # ==== 5 ====
        coeff_2 = [1.4;4.5e-8;4;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8]
        @test quadraticCheck2D(coeff_2,def_tol) == false

        # ==== 3 ====
        coeff_3 = [1.4;45;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8]
        @test quadraticCheck2D(coeff_3,def_tol) == false

        # ==== 2 ====
        coeff_4 = [1.4;4.5e-8;4.5e-8;;45;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8]
        @test quadraticCheck2D(coeff_4,def_tol) == false

        # ==== 7 ====
        coeff_5 = [1.4;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;45;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8]
        @test quadraticCheck2D(coeff_5,def_tol) == false

        # ==== 1 ====
        coeff_6 = [1.4;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;4.5e-8;;4.5e-8;4.5e-8;45]
        @test quadraticCheck2D(coeff_6,def_tol) == false

        # ==== 4 ====
        coeff_7 = [0.;0;0;0;;1e-4;1e-4;0;0;;0;0;0;0;;0;0;0;0]
        @test quadraticCheck2D(coeff_7,def_tol) == false

        # ==== 8 ====
        coeff_8 = [1.;-1e-4;1e-1;;0;1e-4;1e-1;;1;1e-8;1e-8]
        @test quadraticCheck2D(coeff_8,def_tol) == false

        # ==== TRUE ====
        coeff_9 = [-2.41775862e+00;  2.1350353e+00; -3.87766212e-01; -1.33530802e-01;
                    7.06357036e-02;  1.12011784e-02; -2.36782840e-03; -4.94435602e-04;  
                    2.34459237e-05;  1.08934946e-05;  3.43628033e-07; -1.22403275e-07;  
                    -1.17364301e-08;  4.92679129e-10;  1.35077444e-10;  4.27994339e-12;  
                    -7.20345152e-13; -7.05632052e-14;  2.98166221e-16;  4.20922334e-16;  
                    2.41283551e-17; -4.62559699e-19; -1.26044310e-19; -6.53407640e-21;  
                    -1.26117749e-22;;
                    -3.60576002e-01;  1.95403808e-17; -5.06204819e-18;  1.03365377e-16;  
                    -1.65577532e-17; -4.19948703e-17; -1.05565229e-18;  6.05637836e-18;  
                    2.51388762e-20; -3.66287362e-19;  1.84213932e-19; -6.02600539e-20;  
                    -4.76708891e-20;  3.84916105e-20;  1.72497929e-21; -1.94688305e-20;  
                    -1.64407605e-21;  8.56676065e-21;  5.94568259e-21;  2.04424696e-21;  
                    4.31464518e-22;  5.86022006e-23;  5.02784922e-24;  2.49238368e-25;  
                    5.46037066e-27;;
                    -8.50120700e-02;  2.15686921e-16; -1.32718624e-16;  2.14541637e-16;  
                    -6.76581739e-17; -1.18646371e-16;  4.54286919e-17;  2.62556991e-17;  
                    -8.25080039e-18; -3.55369692e-18;  6.80040321e-19;  3.32720227e-19;  
                    -2.08711955e-20; -2.78005463e-20; -1.61970309e-22;  5.27340018e-21;  
                    5.72090567e-22; -1.87422953e-21; -1.32417386e-21; -4.58446410e-22;  
                    -9.72320040e-23; -1.32548947e-23; -1.14043436e-24; -5.66569249e-26;  
                    -1.24339164e-27;;
                     5.90391287e-03; -2.06981686e-17;  1.59282529e-17; -4.16859224e-17;  
                    -1.56805625e-18;  2.92538500e-17;  1.47621361e-18; -6.75419740e-18;  
                    -6.02837355e-19;  8.08463847e-19;  1.01385388e-19; -5.37381884e-20;  
                    -8.60617345e-21;  4.23213004e-22;  5.05583336e-22;  9.76349018e-22;  
                    1.52495494e-22; -3.75058169e-22; -2.80348137e-22; -9.91482693e-23;  
                    -2.12490971e-23; -2.91383819e-24; -2.51640039e-25; -1.25341580e-26;  
                    -2.75617133e-28;;
                     7.69943639e-04; -1.86603688e-17;  1.85692011e-17; -2.27685661e-17;  
                    7.87880916e-18;  1.04664986e-17; -5.22394972e-18; -2.16797109e-18;  
                    9.59788937e-19;  3.02777622e-19; -8.09600520e-20; -3.24865784e-20;  
                    2.27759422e-21;  3.81636249e-21; -8.64737374e-24; -1.06384239e-21;  
                    -1.03102586e-22;  4.18318020e-22;  2.93102778e-22;  1.01177198e-22;  
                    2.14139993e-23;  2.91450279e-24;  2.50445742e-25;  1.24299770e-26;  
                    2.72576409e-28;;
                    -3.14239881e-05;  2.54237805e-18; -2.54930898e-18;  3.32901598e-18;  
                    5.60419818e-19; -2.15639277e-18; -1.62559880e-19;  4.78354195e-19;  
                    5.12754618e-20; -5.68916051e-20; -9.32466909e-21;  4.41877807e-21;  
                    1.03942389e-21; -3.79314483e-22; -5.08709138e-23;  1.07087100e-22;  
                    4.96625002e-24; -5.00840505e-23; -3.35473399e-23; -1.13654145e-23;  
                    -2.37915307e-24; -3.21461682e-25; -2.74814887e-26; -1.35871731e-27;  
                    -2.97065694e-29;;
                    -2.72444536e-06;  5.69068740e-19; -7.72936622e-19;  8.82917884e-19;  
                    -3.26280681e-19; -3.39100639e-19;  2.14120816e-19;  6.44145466e-20;  
                    -4.04031679e-20; -9.26653341e-21;  3.60782301e-21;  1.11298385e-21;  
                    -1.23765426e-22; -1.52753957e-22;  2.30573145e-24;  4.64648467e-23;  
                    4.65779450e-24; -1.82613674e-23; -1.28455066e-23; -4.44118669e-24;  
                    -9.40757235e-25; -1.28104525e-25; -1.10118641e-26; -5.46668201e-28;  
                    -1.19901123e-29;;
                     7.92936961e-08; -1.11916088e-19;  1.55976834e-19; -1.68876091e-19;  
                    2.17682306e-21;  8.31149100e-20; -9.79409585e-21; -1.68436429e-20;  
                    1.31054269e-21;  2.07645319e-21;  2.44240436e-23; -1.96734649e-22;  
                    -2.42735192e-23;  2.51917885e-23;  1.34205098e-24; -8.48018817e-24;  
                    -6.65744027e-25;  3.65124202e-24;  2.51571668e-24;  8.62452951e-25;  
                    1.81778365e-25;  2.46707668e-26;  2.11568236e-27;  1.04844637e-28;  
                    2.29641713e-30;;
                     5.15062459e-09; -1.38742535e-20;  4.13361799e-20; -5.28923474e-20;  
                    2.58065203e-20;  1.65850047e-20; -1.42875279e-20; -2.86889839e-21;  
                    2.64799248e-21;  4.29719167e-22; -2.47334230e-22; -5.53659875e-23;  
                    1.09637297e-23;  7.55504734e-24; -2.98151812e-25; -2.16389599e-24;  
                    -2.32135571e-25;  8.17035476e-25;  5.79207212e-25;  2.00896093e-25;  
                    4.26372508e-26;  5.81356886e-27;  5.00201526e-28;  2.48491411e-29;  
                    5.45313065e-31;;
                    -1.16510717e-10;  1.56209253e-20; -6.06369391e-20;  7.93374646e-20;  
                    -3.80020039e-20; -2.53411745e-20;  2.03898326e-20;  4.45214054e-21;  
                    -3.71067921e-21; -6.52390851e-22;  3.41380367e-22;  8.07825944e-23;  
                    -1.48317724e-23; -1.05769219e-23;  3.88237644e-25;  2.95653344e-24;  
                    3.10595392e-25; -1.11854199e-24; -7.91173360e-25; -2.74189857e-25;  
                    -5.81677611e-26; -7.92906681e-27; -6.82098781e-28; -3.38810999e-29;  
                    -7.43444756e-31;;
                    -6.05139124e-12; -8.01994605e-21;  3.41625715e-20; -4.52734401e-20;  
                    2.25085049e-20;  1.42374740e-20; -1.19605839e-20; -2.48893208e-21;  
                    2.17878465e-21;  3.68163346e-22; -2.01714827e-22; -4.59593708e-23;  
                    8.99624354e-24;  5.97761095e-24; -2.41545662e-25; -1.64690491e-24;  
                    -1.75161287e-25;  6.18058512e-25;  4.37808627e-25;  1.51818413e-25;  
                    3.22191317e-26;  4.39299945e-27;  3.77975449e-28;  1.87772335e-29;  
                    4.12066738e-31;;
                     1.11963805e-13;  2.52493747e-21; -1.08064843e-20;  1.43353712e-20;  
                    -7.15028909e-21; -4.50050890e-21;  3.79783522e-21;  7.86152608e-22;  
                    -6.92046593e-22; -1.16409162e-22;  6.41175034e-23;  1.45502292e-23;  
                    -2.86638974e-24; -1.89266946e-24;  7.71565351e-26;  5.21041109e-25;  
                    5.54993711e-26; -1.95393737e-25; -1.38433256e-25; -4.80076426e-26;  
                    -1.01886647e-26; -1.38923659e-27; -1.19532751e-28; -5.93828565e-30;  
                    -1.30317218e-31;;
                     4.83832962e-15; -4.86337190e-22;  2.06939071e-21; -2.74250361e-21;  
                    1.36497260e-21;  8.61442718e-22; -7.25454252e-22; -1.50473227e-22;  
                    1.32193437e-22;  2.22706176e-23; -1.22438817e-23; -2.78336739e-24;  
                    5.46565869e-25;  3.62406874e-25; -1.46964508e-26; -9.99000586e-26;  
                    -1.06340719e-26;  3.74839524e-26;  2.65546420e-26;  9.20864664e-27;  
                    1.95431017e-27;  2.66468605e-28;  2.29272575e-29;  1.13899755e-30;  
                    2.49954410e-32;;
                    -7.39970248e-17;  5.66975765e-23; -2.40360301e-22;  3.18297545e-22;  
                    -1.58158463e-22; -1.00022850e-22;  8.40928635e-23;  1.74720336e-23;  
                    -1.53228232e-23; -2.58492919e-24;  1.41881434e-24;  3.23016556e-25;  
                    -6.32588626e-26; -4.20869920e-26;  1.69936908e-27;  1.16130179e-26;  
                    1.23543058e-27; -4.35934098e-27; -3.08805218e-27; -1.07084613e-27;  
                    -2.27256726e-28; -3.09858770e-29; -2.66603515e-30; -1.32444389e-31;  
                    -2.90649288e-33;;
                    -3.10999317e-18; -3.70352915e-24;  1.56752856e-23; -2.07494379e-23;  
                    1.03019673e-23;  6.52160620e-24; -5.47858274e-24; -1.13920723e-24;  
                    9.98233628e-25;  1.68511367e-25; -9.24168450e-26; -2.10563211e-26;  
                    4.11778993e-27;  2.74455423e-27; -1.10565862e-28; -7.57706384e-28;  
                    -8.05804491e-29;  2.84500465e-28;  2.01525309e-28;  6.98819433e-29;  
                    1.48303118e-29;  2.02206134e-30;  1.73977961e-31;  8.64291619e-33;  
                    1.89668295e-34;;
                     6.54254269e-20;  1.04498086e-25; -4.42019982e-25;  5.84984281e-25;  
                    -2.90345101e-25; -1.83873717e-25;  1.54416760e-25;  3.21193403e-26;  
                    -2.81351220e-26; -4.75075856e-27;  2.60455628e-27;  5.93629674e-28;  
                    -1.16013175e-28; -7.73922334e-29;  3.11434895e-30;  2.13721232e-29;  
                    2.27250288e-30; -8.02570888e-30; -5.68488269e-30; -1.97130302e-30;  
                    -4.18346871e-31; -5.70399420e-32; -4.90769883e-33; -2.43805308e-34;  
                    -5.35028560e-36]
        tol_9 = 9.213128325146227e-13
        @test quadraticCheck2D(coeff_9,tol_9) == true
        
        # ==== 9 ====
        coeff_10 = [-2.41775862e+00;  -1.350353e+00; -3.466212e-01; -1.33530802e-01;
                    7.06357036e-02;  1.12011784e-02; -2.36782840e-03; -4.94435602e-04;  
                    2.34459237e-05;  1.08934946e-05;  3.43628033e-07; -1.22403275e-07;  
                    -1.17364301e-08;  4.92679129e-10;  1.35077444e-10;  4.27994339e-12;  
                    -7.20345152e-13; -7.05632052e-14;  2.98166221e-16;  4.20922334e-16;  
                    2.41283551e-17; -4.62559699e-19; -1.26044310e-19; -6.53407640e-21;  
                    -1.26117749e-22;;
                    -3.105760023e-1;  30.03808e-3; -5.06204819e-18;  1.03365377e-16;  
                    -1.65577532e-17; -4.19948703e-17; -1.05565229e-18;  6.05637836e-18;  
                    2.51388762e-20; -3.66287362e-19;  1.84213932e-19; -6.02600539e-20;  
                    -4.76708891e-20;  3.84916105e-20;  1.72497929e-21; -1.94688305e-20;  
                    -1.64407605e-21;  8.56676065e-21;  5.94568259e-21;  2.04424696e-21;  
                    4.31464518e-22;  5.86022006e-23;  5.02784922e-24;  2.49238368e-25;  
                    5.46037066e-27;;
                    -11.60120700e-01;  2.15686921e-16; -1.32718624e-16;  2.14541637e-16;  
                    -6.76581739e-17; -1.18646371e-2;  4.54286919e-17;  2.62556991e-17;  
                    -8.25080039e-18; -3.55369692e-6;  6.80040321e-19;  3.32720227e-19;  
                    -2.08711955e-20; -2.78005463e-20; -1.61970309e-22;  5.27340018e-21;  
                    5.72090567e-22; -1.87422953e-21; -1.32417386e-21; -4.58446410e-22;  
                    -9.72320040e-23; -1.32548947e-23; -1.14043436e-24; -5.66569249e-26;  
                    -1.24339164e-27;;
                     5.90391287e-03; -2.06981686e-17;  1.59282529e-17; -4.16859224e-17;  
                    -1.56805625e-18;  2.92538500e-17;  1.47621361e-18; -6.75419740e-18;  
                    -6.02837355e-19;  8.08463847e-19;  1.01385388e-19; -5.37381884e-20;  
                    -8.60617345e-21;  4.23213004e-22;  5.05583336e-22;  9.76349018e-22;  
                    1.52495494e-22; -3.75058169e-3; -2.80348137e-22; -9.91482693e-23;  
                    -2.12490971e-23; -2.91383819e-24; -2.51640039e-25; -1.25341580e-26;  
                    -2.75617133e-28;;
                     7.69943639e-04; -1.86603688e-17;  1.85692011e-17; -2.27685661e-17;  
                    7.87880916e-18;  1.04664986e-17; -5.22394972e-18; -2.16797109e-18;  
                    9.59788937e-19;  3.02777622e-19; -8.09600520e-20; -3.24865784e-20;  
                    2.27759422e-21;  3.81636249e-21; -8.64737374e-24; -1.06384239e-21;  
                    -1.03102586e-22;  4.18318020e-22;  2.93102778e-22;  1.01177198e-22;  
                    2.14139993e-23;  2.91450279e-24;  2.50445742e-25;  1.24299770e-26;  
                    2.72576409e-28;;
                    -3.14239881e-05;  2.54237805e-18; -2.54930898e-18;  3.32901598e-18;  
                    5.60419818e-19; -2.15639277e-18; -1.62559880e-19;  4.78354195e-19;  
                    5.12754618e-20; -5.68916051e-20; -9.32466909e-21;  4.41877807e-21;  
                    1.03942389e-21; -3.79314483e-22; -5.08709138e-4;  1.07087100e-22;  
                    4.96625002e-24; -5.00840505e-23; -3.35473399e-23; -1.13654145e-23;  
                    -2.37915307e-24; -3.21461682e-25; -2.74814887e-26; -1.35871731e-27;  
                    -2.97065694e-29;;
                    -2.72444536e-06;  5.69068740e-19; -7.72936622e-19;  8.82917884e-19;  
                    -3.26280681e-19; -3.39100639e-19;  2.14120816e-19;  6.44145466e-20;  
                    -4.04031679e-20; -9.26653341e-21;  3.60782301e-21;  1.11298385e-21;  
                    -1.23765426e-22; -1.52753957e-22;  2.30573145e-24;  4.64648467e-23;  
                    4.65779450e-24; -1.82613674e-23; -1.28455066e-23; -4.44118669e-24;  
                    -9.40757235e-25; -1.28104525e-25; -1.10118641e-26; -5.46668201e-28;  
                    -1.19901123e-29;;
                     7.92936961e-08; -1.11916088e-19;  1.55976834e-19; -1.68876091e-19;  
                    2.17682306e-21;  8.31149100e-20; -9.79409585e-21; -1.68436429e-20;  
                    1.31054269e-21;  2.07645319e-21;  2.44240436e-23; -1.96734649e-22;  
                    -2.42735192e-23;  2.51917885e-23;  1.34205098e-24; -8.48018817e-24;  
                    -6.65744027e-25;  3.65124202e-24;  2.51571668e-24;  8.62452951e-25;  
                    1.81778365e-25;  2.46707668e-26;  2.11568236e-27;  1.04844637e-28;  
                    2.29641713e-30;;
                     5.15062459e-09; -1.38742535e-20;  4.13361799e-20; -5.28923474e-20;  
                    2.58065203e-20;  1.65850047e-20; -1.42875279e-20; -2.86889839e-21;  
                    2.64799248e-21;  4.29719167e-22; -2.47334230e-22; -5.53659875e-23;  
                    1.09637297e-23;  7.55504734e-24; -2.98151812e-25; -2.16389599e-24;  
                    -2.32135571e-25;  8.17035476e-25;  5.79207212e-25;  2.00896093e-25;  
                    4.26372508e-26;  5.81356886e-27;  5.00201526e-28;  2.48491411e-29;  
                    5.45313065e-31;;
                    -1.16510717e-10;  1.56209253e-20; -6.06369391e-20;  7.93374646e-20;  
                    -3.80020039e-20; -2.53411745e-20;  2.03898326e-20;  4.45214054e-21;  
                    -3.71067921e-21; -6.52390851e-22;  3.41380367e-22;  8.07825944e-23;  
                    -1.48317724e-23; -1.05769219e-23;  3.88237644e-25;  2.95653344e-24;  
                    3.10595392e-25; -1.11854199e-24; -7.91173360e-25; -2.74189857e-25;  
                    -5.81677611e-26; -7.92906681e-27; -6.82098781e-28; -3.38810999e-29;  
                    -7.43444756e-31;;
                    -6.05139124e-12; -8.01994605e-21;  3.41625715e-20; -4.52734401e-20;  
                    2.25085049e-20;  1.42374740e-20; -1.19605839e-20; -2.48893208e-21;  
                    2.17878465e-21;  3.68163346e-22; -2.01714827e-22; -4.59593708e-23;  
                    8.99624354e-24;  5.97761095e-24; -2.41545662e-25; -1.64690491e-24;  
                    -1.75161287e-25;  6.18058512e-25;  4.37808627e-25;  1.51818413e-25;  
                    3.22191317e-26;  4.39299945e-27;  3.77975449e-28;  1.87772335e-29;  
                    4.12066738e-31;;
                     1.11963805e-13;  2.52493747e-21; -1.08064843e-20;  1.43353712e-20;  
                    -7.15028909e-21; -4.50050890e-21;  3.79783522e-21;  7.86152608e-22;  
                    -6.92046593e-22; -1.16409162e-22;  6.41175034e-23;  1.45502292e-23;  
                    -2.86638974e-24; -1.89266946e-24;  7.71565351e-26;  5.21041109e-25;  
                    5.54993711e-26; -1.95393737e-25; -1.38433256e-25; -4.80076426e-26;  
                    -1.01886647e-26; -1.38923659e-27; -1.19532751e-28; -5.93828565e-30;  
                    -1.30317218e-31;;
                     4.83832962e-15; -4.86337190e-22;  2.06939071e-21; -2.74250361e-21;  
                    1.36497260e-21;  8.61442718e-22; -7.25454252e-22; -1.50473227e-22;  
                    1.32193437e-22;  2.22706176e-23; -1.22438817e-23; -2.78336739e-24;  
                    5.46565869e-25;  3.62406874e-25; -1.46964508e-26; -9.99000586e-26;  
                    -1.06340719e-26;  3.74839524e-26;  2.65546420e-26;  9.20864664e-27;  
                    1.95431017e-27;  2.66468605e-28;  2.29272575e-29;  1.13899755e-30;  
                    2.49954410e-32;;
                    -7.39970248e-17;  5.66975765e-23; -2.40360301e-22;  3.18297545e-22;  
                    -1.58158463e-22; -1.00022850e-22;  8.40928635e-23;  1.74720336e-23;  
                    -1.53228232e-23; -2.58492919e-24;  1.41881434e-24;  3.23016556e-25;  
                    -6.32588626e-26; -4.20869920e-26;  1.69936908e-27;  1.16130179e-26;  
                    1.23543058e-27; -4.35934098e-27; -3.08805218e-27; -1.07084613e-27;  
                    -2.27256726e-28; -3.09858770e-29; -2.66603515e-30; -1.32444389e-31;  
                    -2.90649288e-33;;
                    -3.10999317e-18; -3.70352915e-24;  1.56752856e-23; -2.07494379e-23;  
                    1.03019673e-23;  6.52160620e-24; -5.47858274e-24; -1.13920723e-24;  
                    9.98233628e-25;  1.68511367e-25; -9.24168450e-26; -2.10563211e-26;  
                    4.11778993e-27;  2.74455423e-27; -1.10565862e-28; -7.57706384e-28;  
                    -8.05804491e-29;  2.84500465e-28;  2.01525309e-28;  6.98819433e-29;  
                    1.48303118e-29;  2.02206134e-30;  1.73977961e-31;  8.64291619e-33;  
                    1.89668295e-34;;
                     6.54254269e-20;  1.04498086e-25; -4.42019982e-25;  5.84984281e-25;  
                    -2.90345101e-25; -1.83873717e-25;  1.54416760e-25;  3.21193403e-26;  
                    -2.81351220e-26; -4.75075856e-27;  2.60455628e-27;  5.93629674e-28;  
                    -1.16013175e-28; -7.73922334e-29;  3.11434895e-30;  2.13721232e-29;  
                    2.27250288e-30; -8.02570888e-30; -5.68488269e-30; -1.97130302e-30;  
                    -4.18346871e-31; -5.70399420e-32; -4.90769883e-33; -2.43805308e-34;  
                    -5.35028560e-36]
        tol_10 = 9.213128325146227e-13
        @test quadraticCheck2D(coeff_10,tol_10) == false

        # ==== 6 ====
        coeff_11 = [ 4.70735616e+00; -6.95780074e-01;  6.18900109e-01;  3.47063888e-01;  
            -1.13131842e-01; -3.41894257e-02;  7.05617336e-03;  1.47943755e-03;  
            -2.24876952e-04; -3.62291507e-05;  4.36812545e-06;  5.72210074e-07;  
            -5.72236927e-08; -6.31995037e-09;  5.40190335e-10;  5.15878298e-11;  
            -3.85094418e-12; -3.24376793e-13;  2.17648036e-14;  1.49128808e-15;  
            -6.30612798e-17; -1.24619967e-17;  1.04119251e-18; -2.44882147e-20;; 
            -5.60466541e+00;  5.40121244e-16;  4.17371955e-16;  4.16917125e-17;  
            -9.37819282e-17; -8.41574438e-17; -3.02262119e-16;  3.31414694e-18;  
            -4.13721501e-17;  6.75886047e-17;  1.29937845e-16; -2.86588995e-17;  
            -5.13119500e-17; -5.02903038e-17;  9.82897446e-17; -5.48933461e-17;  
            1.30540246e-17;  1.43115498e-19; -9.73502364e-19;  2.93753395e-19;  
            -4.62918212e-20;  4.27786475e-21; -2.19949728e-22;  4.87918072e-24;; 
             2.36572471e+00; -8.69935196e-17; -2.12656759e-16;  1.90739246e-18;  
            1.03522187e-16;  2.86342409e-17;  1.46413864e-16;  2.83832409e-19;  
            6.60626213e-17; -6.42194474e-19; -1.39542373e-17; -1.33572479e-16;  
            1.22717793e-16; -2.02009223e-17; -2.64492076e-17;  2.96528933e-17;  
            -2.08903175e-17;  1.04467360e-17; -3.56347647e-18;  8.15453823e-19;  
            -1.23270717e-19;  1.18329984e-20; -6.54764646e-22;  1.59322259e-23;; 
            -3.17047781e-01;  2.09768248e-17;  8.80060051e-17; -1.97467403e-17;  
            8.15575285e-17;  1.53834950e-16; -1.24987768e-16;  8.26511789e-17;  
            -1.96345091e-17; -2.97900841e-17;  4.13875352e-17; -8.64162383e-17;  
            1.39980025e-16; -1.21904900e-16;  3.47440980e-17;  3.30738799e-17;  
            -4.14259122e-17;  2.22998734e-17; -7.32095880e-18;  1.57975847e-18;  
            -2.26150027e-19;  2.07624623e-20; -1.10992993e-21;  2.63240752e-23;; 
            -1.23842460e-01; -2.49250385e-16; -3.52013200e-16;  3.32168494e-18;  
            2.41471659e-17; -2.75116632e-16;  2.21055643e-16;  2.71188774e-17;  
            8.06380341e-17; -3.41792307e-17; -1.27622146e-16;  1.61359447e-16;  
            9.31664077e-19; -1.74836018e-16;  1.66026035e-16; -5.80713380e-17;  
            -6.18553989e-18;  1.39951657e-17; -6.19288822e-18;  1.52642269e-18;  
            -2.34945357e-19;  2.25314886e-20; -1.23849168e-21;  2.99214838e-23;; 
             3.12325249e-02; -4.22341280e-17;  1.81808768e-16;  1.59922768e-17;  
            6.61519913e-17;  1.72440431e-16;  3.17208163e-17; -2.80192695e-17;  
            1.51734899e-17; -7.96701004e-17; -6.33197190e-17;  9.62857746e-17;  
            -4.74035976e-17;  8.89779393e-17; -1.10698168e-16;  6.16976956e-17;  
            -1.37195739e-17; -2.12242947e-18;  2.28359991e-18; -7.02125352e-19;  
            1.20567680e-19; -1.23735784e-20;  7.13017169e-22; -1.78461326e-23;; 
             7.72420786e-03;  1.70772106e-16;  2.92745735e-16;  4.90222373e-17;  
            5.73087038e-17; -1.36056844e-17; -2.96215284e-17; -1.56699956e-16;  
            -5.37542120e-17; -6.56428331e-17;  7.45034090e-17;  1.42591003e-16;  
            -1.11373308e-16; -5.37045319e-18;  7.92376305e-18;  1.90162371e-17;  
            -1.73479543e-17;  6.64483123e-18; -1.38468911e-18;  1.50017339e-19;  
            -3.48064124e-21; -1.06216570e-21;  1.18390216e-22; -4.02807614e-24;; 
            -1.35148717e-03;  9.41322885e-17; -2.06315879e-17; -8.24005665e-17;  
            8.52381036e-17; -7.22059014e-17;  6.42399221e-17; -3.16026407e-17;  
            1.00929751e-16; -5.48155851e-17; -5.26486054e-17; -4.55741620e-17;  
            5.50723061e-17;  7.76447657e-17; -1.02658629e-16;  2.94294791e-17;  
            1.53334520e-17; -1.56361646e-17;  6.16728300e-18; -1.43207241e-18;  
            2.10754167e-19; -1.94343969e-20;  1.02985807e-21; -2.40187656e-23;; 
            -2.46166900e-04;  1.95767725e-16;  7.49956837e-17;  9.92965661e-17;  
            -3.53138782e-17; -4.59728099e-17; -1.55224541e-16;  3.03557911e-17;  
            -1.58387191e-16;  1.44042261e-16;  1.14243046e-16; -8.08492742e-17;  
            -7.89628879e-18; -4.29901623e-17;  5.68343083e-17; -8.16692850e-18;  
            -1.90356469e-17;  1.48017103e-17; -5.52498925e-18;  1.25861681e-18;  
            -1.84009693e-19;  1.69601246e-20; -9.01663610e-22;  2.11530192e-23;; 
             3.30958427e-05; -3.14548269e-17; -1.56009134e-17;  4.77361576e-17;  
            -7.64849391e-17; -2.03689813e-17; -7.10631289e-17; -4.65945603e-17;  
            3.55030817e-17;  1.74314842e-17;  2.74959082e-17; -1.31816184e-17;  
            -3.27163997e-17;  4.11965355e-17; -2.71237517e-17;  1.25120473e-17;  
            -3.75506101e-18;  4.74416661e-19;  1.13361513e-19; -6.54375469e-20;  
            1.40388371e-20; -1.64983210e-21;  1.04913610e-22; -2.83774766e-24;; 
             4.78167233e-06; -1.17321227e-16; -2.13411262e-16; -1.44111909e-17; 
            4.72871918e-17;  9.71194553e-17;  1.25313638e-16;  7.26937197e-17;  
            6.10002005e-18; -5.08033219e-17; -2.38837756e-17; -7.60943288e-17;  
            1.45731695e-16; -1.04631036e-16;  5.37965181e-17; -2.35186505e-17;  
            6.80761616e-18; -4.31693504e-19; -4.90839333e-19;  2.08777127e-19;  
            -4.18532447e-20;  4.76047099e-21; -2.96030339e-22;  7.86153164e-24;; 
            -5.22722014e-07; -8.81240341e-17;  5.47973944e-17;  3.17907438e-17;  
            -3.38701703e-17; -1.28308003e-17;  3.20830045e-18; -4.59282150e-17;  
            -3.56974793e-17;  8.21726962e-18;  4.36012171e-17;  6.38483695e-17;  
            -9.03800681e-17;  1.10095280e-18;  3.92846721e-17; -1.83885923e-17;  
            -9.59612415e-19;  3.86432767e-18; -1.71344982e-18;  4.09709193e-19;  
            -6.05692282e-20;  5.56005219e-21; -2.92367041e-22;  6.76262285e-24;; 
            -6.26412755e-08;  3.14202991e-17;  9.65222069e-17; -1.44500262e-16;  
            -3.29564864e-17; -6.51543564e-18; -2.64680357e-17;  1.13168395e-16;  
            9.51130929e-17;  7.88372276e-18; -1.61131053e-16;  3.10264115e-17;  
            -3.10668182e-17;  1.43240042e-16; -1.11704233e-16;  1.01783400e-17;  
            3.09000985e-17; -2.18111436e-17;  7.71429699e-18; -1.69419831e-18;  
            2.41189037e-19; -2.17889867e-20;  1.14061469e-21; -2.64372910e-23;; 
             5.77336481e-09;  5.11752480e-17; -2.26268096e-17;  2.48223744e-17;  
            1.06080024e-16;  1.52280294e-17;  1.08757761e-17; -1.21598934e-16;  
            -7.59316899e-17; -3.28008063e-17;  1.09521547e-16;  3.10009284e-17;  
            1.06685875e-17; -1.07085672e-16;  5.65055327e-17;  2.39705986e-17;  
            -3.90214225e-17;  2.05128133e-17; -6.25571452e-18;  1.23215423e-18;  
            -1.59897651e-19;  1.32745439e-20; -6.41364478e-22;  1.37518237e-23;; 
             5.91332384e-10;  4.87150776e-17; -3.81829180e-17;  1.04502548e-16;  
            -1.33343533e-16; -9.45046592e-17; -1.53918059e-17;  4.73316834e-17;  
            7.12843941e-17;  5.06245980e-17; -2.08414623e-17; -9.30522154e-17;  
            2.44300199e-17;  4.03721749e-17; -3.87756443e-18; -3.03563290e-17;  
            2.46402700e-17; -9.70346823e-18;  2.28509062e-18; -3.33726197e-19;  
            2.87095169e-20; -1.15511695e-21; -5.95804325e-24;  1.52998186e-24;; 
            -4.71250167e-11; -9.71835707e-17;  1.81389317e-17; -2.95973273e-17;  
            1.42557055e-16;  1.34019991e-16;  1.00544708e-17; -1.91281569e-17;  
            -1.14115492e-16; -4.48064699e-17;  4.72717020e-17;  4.28725458e-17;  
            1.85795350e-17; -6.20963773e-17;  1.44099490e-17;  2.50192096e-17;  
            -2.31418672e-17;  9.87373997e-18; -2.57403850e-18;  4.38640555e-19;  
            -4.90946028e-20;  3.46689150e-21; -1.38839198e-22;  2.36088380e-24;; 
            -4.21586827e-12;  4.61423377e-17;  6.00034272e-18; -7.36402029e-17;  
            -1.22030749e-16; -9.49788673e-17;  5.19531069e-19;  3.06550679e-17;  
            1.17934537e-16;  2.85486477e-17; -8.54604571e-17;  1.77767872e-17;  
            -5.65732996e-17;  8.56590230e-17; -3.05655682e-17; -1.97245779e-17;  
            2.48390915e-17; -1.22711620e-17;  3.65838384e-18; -7.18996437e-19;  
            9.44067704e-20; -8.01507735e-21;  3.99480673e-22; -8.90162057e-24;; 
             2.96011473e-13; -1.68354759e-18; -8.64100941e-18;  7.96752809e-17;  
            7.32812626e-17;  4.11769527e-17; -3.42804357e-18; -2.88584949e-17;  
            -7.30093386e-17; -1.40883516e-17;  6.69494526e-17; -2.81390633e-17;  
            4.66852581e-17; -6.23067193e-17;  2.40111556e-17;  1.22633349e-17;  
            -1.73504203e-17;  8.96130099e-18; -2.76599484e-18;  5.60735988e-19;  
            -7.57732292e-20;  6.60860876e-21; -3.37811264e-22;  7.70815628e-24;; 
             2.35431048e-14; -7.08135878e-18;  4.05322314e-18; -4.01891756e-17;  
            -3.00693185e-17; -1.18038103e-17;  1.84855008e-18;  1.48674496e-17;  
            2.92139145e-17;  5.30023362e-18; -3.03672460e-17;  1.48020366e-17;  
            -2.14798356e-17;  2.75041017e-17; -1.07367597e-17; -5.28658099e-18;  
            7.67617455e-18; -4.01109213e-18;  1.24977052e-18; -2.55468955e-19;  
            3.47806810e-20; -3.05402808e-21;  1.57076455e-22; -3.60430924e-24;; 
            -1.50367599e-15;  3.47154919e-18; -1.14615238e-18;  1.24493151e-17;  
            8.49456808e-18;  2.29950959e-18; -5.15376272e-19; -4.75530168e-18;  
            -7.91291416e-18; -1.46651875e-18;  8.89836703e-18; -4.58128847e-18;  
            6.34741211e-18; -7.97246741e-18;  3.09875854e-18;  1.55201807e-18;  
            -2.24721063e-18;  1.17640993e-18; -3.67361577e-19;  7.52583834e-20;  
            -1.02671764e-20;  9.03263644e-22; -4.65386043e-23;  1.06959874e-24;; 
            -9.48500312e-17; -8.68102847e-19;  2.18313028e-19; -2.54217631e-18;  
            -1.65662089e-18; -3.02959701e-19;  8.59862514e-20;  9.97760300e-19;  
            1.47425245e-18;  2.89220469e-19; -1.75167201e-18;  9.25138392e-19;  
            -1.25926104e-18;  1.56335563e-18; -6.01862321e-19; -3.10805234e-19;  
            4.45111603e-19; -2.32717685e-19;  7.26652729e-20; -1.48901240e-20;  
            2.03215307e-21; -1.78854177e-22;  9.21891416e-24; -2.11965546e-25;; 
             3.52056207e-18;  1.32174704e-19; -2.85408417e-20;  3.45540357e-19;  
            2.19720374e-19;  2.59732735e-20; -8.60099203e-21; -1.38511109e-19;  
            -1.86978045e-19; -3.93151617e-20;  2.31601851e-19; -1.24078407e-19;  
            1.67843838e-19; -2.06588388e-19;  7.86653357e-20;  4.19501657e-20;  
            -5.93286998e-20;  3.09506975e-20; -9.65628006e-21;  1.97797014e-21;  
            -2.69900917e-22;  2.37530699e-23; -1.22433341e-24;  2.81514379e-26;; 
             7.77590671e-19; -1.24055360e-20;  2.47592304e-21; -3.02353436e-20;  
            -1.89662929e-20; -1.31694905e-21;  4.63960009e-22;  1.23157596e-20;  
            1.54717760e-20;  3.49368950e-21; -1.98126498e-20;  1.07169286e-20;  
            -1.44795003e-20;  1.76916062e-20; -6.66295030e-21; -3.66205233e-21;  
            5.11713596e-21; -2.66327175e-21;  8.30089542e-22; -1.69945133e-22;  
            2.31826939e-23; -2.03987451e-24;  1.05133263e-25; -2.41723381e-27;; 
            -6.11890076e-20;  6.63931548e-22; -1.28852696e-22;  1.54659692e-21;  
            9.62702378e-22;  3.06404244e-23; -8.62093470e-24; -6.37614369e-22;  
            -7.54923133e-22; -1.82622624e-22;  9.93946357e-22; -5.41788024e-22;  
            7.32676760e-22; -8.89158165e-22;  3.31353077e-22;  1.87180580e-22;  
            -2.58705296e-22;  1.34349771e-22; -4.18349621e-23;  8.56075811e-24;  
            -1.16748374e-24;  1.02713213e-25; -5.29334785e-27;  1.21701542e-28;; 
             1.38296922e-21; -1.55779020e-23;  3.04690935e-24; -3.52341833e-23;  
            -2.18349284e-23; -4.95751328e-26; -1.48104467e-25;  1.46571886e-23;  
            1.65042533e-23;  4.25949365e-24; -2.22561552e-23;  1.22166573e-23;  
            -1.65487832e-23;  1.99521614e-23; -7.36149106e-24; -4.26278052e-24;  
            5.83415856e-24; -3.02380148e-24;  9.40819725e-25; -1.92447964e-25;  
            2.62406192e-26; -2.30844583e-27;  1.18965659e-28; -2.73527671e-30]
        tol_11 = 1.7289206528181043e-13
        @test quadraticCheck2D(coeff_11,tol_11) == false

        # ==== 2D CHECK (early) ====
        coeff_12 = [1.;2;3;;1;2;3;;;4;3;2;;1;2;3;;;2345;52;34;;1;2;3]
        @test quadraticCheck2D(coeff_12,def_tol) == false

        # ==== SMALL ARRAY CHECK (2) ====
        coeff_13 = [1.;2;;-1;1]
        @test quadraticCheck2D(coeff_13,def_tol) == false

        # ==== SMALL ARRAY CHECK (TRUE) ====
        coeff_14 = [.0001;;.0001]
        @test quadraticCheck2D(coeff_14,def_tol) == true

    end
end

