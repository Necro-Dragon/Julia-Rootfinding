include("../../Julia-Rootfinding/src/ChebyshevSubdivisionSolver.jl")
using Test

function test_all_ChebyshevSubdivisionSolver()
    @testset "All tests in ChebyshevSubdivisionSolverTest.jl" begin
        test_getLinearTerms()
        test_linearCheck1()
        test_reduceSolveDim()
        test_transformChebInPlace1D()
    end
end

function test_getLinearTerms()
    @testset "getLinearTerms unit tests" begin
        M_1 = reshape(collect(0:15),(2,2,2,2))
        A_1_expected = [8; 4; 2; 1]
        @test isapprox(A_1_expected,getLinearTerms(M_1))

        M_2 = reshape(collect(0:15),(2,2,4))
        A_2_expected = [4; 2; 1]
        @test isapprox(A_2_expected,getLinearTerms(M_2))

        M_3 = [43.2;12.2;-9.2]
        A_3_expected = [12.2]
        @test isapprox(A_3_expected,getLinearTerms(M_3))
        
        M_4 = reshape(collect(0:(2*15*4*6-1)),(6,4,15,2))
        A_4_expected = [360; 24; 6; 1]
        @test isapprox(A_4_expected,getLinearTerms(M_4))

        M_5 = reshape(collect(0:(3*4-1)),(4,1,3))
        A_5_expected = [4; 0; 1]
        @test isapprox(A_5_expected,getLinearTerms(M_5))


    end
end

function test_linearCheck1()
    @testset "linearCheck1 unit tests" begin
        A1 = [-1.12215095; -0.10896646; -0.20570858;;
                1.61496991;  0.36087537;  0.70263142;;
                1.11501566;  1.00547594; -1.96518304]
        totalErrs1 = [3.04770461; 7.78421744; 7.01361619]
        consts1 = [1.06289306; -0.36122354;  2.87185328]
        expecteda1 = [0.17843629682798045621; -5.97541921291522903914; 0.35379575125989282114]
        expectedb1 = [0.13891640768525181926; 0.26299355308293126399; 2.56893787868228251625]
        ao1, bo1 = linearCheck1(totalErrs1,A1,consts1)
        @test isapprox(expecteda1,ao1)
        @test isapprox(expectedb1,bo1)

        A2 = [1.80704361; 0.16184698; 0.12777497;;
                -1.50763366; -0.0496367; -0.03896966;;
                1.1471166; 1.60014553; -1.22405313]
        totalErrs2 = [3.12346641; 7.35040987; 6.71495483]
        consts2 = [0.43827528; 0.03844889; 2.66922695]
        expecteda2 = [-0.72849531284969915035; -3.19646507402361113037; -0.12454345016870327356]
        expectedb2 = [0.19996601042997674824; -0.13976516248493942030; 4.48583608458237481642]
        ao2, bo2 = linearCheck1(totalErrs2,A2,consts2)
        @test isapprox(expecteda2,ao2)
        @test isapprox(expectedb2,bo2)

        A3 = [1.80704361; 0.16184698; 0.12777497;;
                -1.50763366; -0.0496367;  -0.03896966;;
                -1.50763366; -0.0496367;  0.03896966]
        totalErrs3 = [3.12346641; 7.35040987; 6.71495483]
        consts3 = [0.43827528; 0.03844889; 2.66922695]
        expecteda3 = [0.08697917370722585417; -18.29888596005930878619; -23.44505688398909626358]
        expectedb3 = [0.24342093216001564615; 12.88296432840451899438; 16.58494523614445270709]
        ao3,bo3 = linearCheck1(totalErrs3,A3,consts3)
        @test isapprox(expecteda3,ao3)
        @test isapprox(expectedb3,bo3)

        A4 = reshape([1.50001956],(1,1)) #1 dimensional test
        totalErrs4 = [1.50001956]
        consts4 = [0.]
        expecteda4 = [0.]
        expectedb4 = [0.]
        ao4,bo4 = linearCheck1(totalErrs4,A4,consts4)
        @test isapprox(expecteda4,ao4)
        @test isapprox(expectedb4,bo4)

        A5 = [-.843750000; -1.87818750; -1.84275000; -.0107162044; -.00639690758; -.0137320288;;
                1.76080078; -.211296094; -.207309375; -.0159523129; .00889275657; -.0159523129;;
                .000176557928; -.00280220616; -.000701926758;  .0750781250; -1.28906250; -.0703125000;;
                1.36514364; -.163754473; -.160664766; -.163754473; .00504338969; -.00586371477;;
                .0289072432; -.240222558; -1.16359475; -1.12860484; -.190846439; -1.11307774;;
                .0903976590; -1.43472955; -.359386500;  0.0; 0.0;  0.0]
        totalErrs5 = [13.43636626; 31.17953809; 5.93851452; 33.20880558; 10.53793091; 1601.6394327]
        consts5 = [-0.07413729; -0.19634937;  0.90146117;-0.16101726; -0.72744493;  0.71811873]
        expecteda5 = [-14.92458223407407302830; -6.15390037469634965106; -6.29147538190204791420; -8.33713070909743869663; -2.20821696387878763090; -8.46738087673912076525]
        expectedb5 = [14.74884939851851761716; 6.07495480616285643549; 6.21101162935829531619; 7.04802595920109808958; 3.60684762763636346250; 7.16029350294975763802]
        ao5,bo5 = linearCheck1(totalErrs5,A5,consts5)
        @test isapprox(expecteda5,ao5)
        @test isapprox(expectedb5,bo5)

        A6 = [-1.09679818; -.939093750; -.921375000; -.0138146058; -.00106830799; -.0137307266;;
                .915137070; -1.05695980; -1.03701717; -.0149230031; .00237984138; -.0298460061;;
                .000607404435; -.00309112001; .000675877264;  .0750781250; -1.10873059; -.0379851973;;
                1.42079568; -1.63828770; -1.60737661; -1.63828770; -.00611697632; -.00852711940;;
                .901029633; -.240222558; -1.16359475; -1.12860484; -.0167700634; -1.01490072;;
                .310991071; -1.58265345;  .346049159;  0.0; 0.0; 0.0]
        totalErrs6 = [5.35450865; 14.31962505; 5.26765467; 30.10577724; 8.74980906; 1261.57287396]
        consts6 = [-0.06306681; -1.04453075; 1.44087973; -1.64179371; 0.23798175; 0.63996163]
        expecteda6 = [-3.88194523626944754113; -4.70178286246713916796; -4.81143253289919847759; -6.33103852363418972971; -1.15191610254029308535; -7.15236938643614461597]
        expectedb6 = [3.76694356841474720099; 4.56746866859671918348; 4.67453537376203964726; 6.75276584849662775412; 3.75106821937689982605; 7.62134481488987525211]
        ao6,bo6 = linearCheck1(totalErrs6,A6,consts6)
        @test isapprox(expecteda6,ao6)
        @test isapprox(expectedb6,bo6)

        A7 = [0; -.939093750; 0; -.0138146058; -.00106830799; -.0137307266;;
                0; -1.05695980; 0; -.0149230031; .00237984138; -.0298460061;;
                0; 0;  0;  0; 0; 0;;
                0; -1.63828770; 0; -1.63828770; -.00611697632; -.00852711940;;
                0; 0; 0; 0; 0; 0;;
                0; 0;  0;  0.0; 0.0; 0.0]
        totalErrs7 = [5.35450865; 14.31962505; 5.26765467; 30.10577724; 8.74980906; 1261.57287396]
        consts7 = [-0.06306681; -1.04453075; 1.44087973; -1.64179371; 0.23798175; 0.63996163]
        expecteda7 = [-Inf; -4.70178286246713916796; -Inf; -17.37636774053788002448; -4920.67627681775957171340; -388.96542615596172254300]
        expectedb7 = [Inf; 4.56746866859671918348; Inf; 15.37208764980656283683; 4383.87717081762366433395; 379.77919561809636661565]
        ao7,bo7 = linearCheck1(totalErrs7,A7,consts7)
        @test isapprox(expecteda7,ao7)
        @test isapprox(expectedb7,bo7)
    end
end

function test_reduceSolveDim()
    @testset "reduceSolveDim unit tests" begin 
        # # 2d case
        # Ms_1 = [[3.1;-2;34;.000001;.0002;;4;1;2;.0002;.0102], [9.836;3.1;-.031;.001;-.045;.00002;;15.2344;42.234;2;4;3;.0023]]
        # errors_1 = [.00002;.0001]
        # trackedInterval_1 = TrackedInterval([1;1;;-3;2])
        # trackedInterval_1.reducedDims = [1]
        # trackedInterval_1.solvedVals = [1.;2.;3.]
        # dim_1 = 0
        # expected_new_Ms_1 = [[3.10000000000000008882; -2.00000000000000000000; 34.00000000000000000000; 0.00000100000000000000; 0.00020000000000000001]]
        # expected_new_errors_1 = [0.00002]
        # expected_new_trackedInterval_1 = [-3;2]

        # new_Ms_1, new_errors_1, new_trackedInterval_1 = reduceSolvedDim(Ms_1,errors_1,trackedInterval_1,dim_1)
        # @test isapprox(expected_new_Ms_1[1],new_Ms_1[1])
        # @test isapprox(expected_new_errors_1,new_errors_1)
        # @test isapprox(expected_new_trackedInterval_1,new_trackedInterval_1.interval)
        # @test (1 == new_trackedInterval_1.ndim)
        # @test ([1;0] == new_trackedInterval_1.reducedDims)
        # @test ([1.; 2.; 3.; 1.0] == new_trackedInterval_1.solvedVals)

        # 3d case
        Ms_2 = [[5.1;-2;2.4;.000001;.0002;.001001;;18;4;2.12;.0002;.0102;.045;;5;3.2;4.2;11;.0002;.0909;;;8.12;3.332;4.1232;11;.012002;.091239;;45.23;34;7.23;2.0;.0002;.011239;;8.127;3.2;4.3;11;.012002;.093309;;;54.1;13.332;6.1232;12.1;.12;.12239;;4.2343;5.433;94.3;8.340;.012302;.11239;;77.127;81.2;5.3;1;.02;.03], [5.836;3.122;-.031;;13.234344;42.001;.0012;;5.9;13.0022333;.0056;;;3.2;12;.0023;;56.2;1;.00233;;5.2;4.5;.013;;;5.2;4.5;.013;;3.2;12;.0023;;5.2;4.5;.013],[2;2;.002;.001;;2.1;2.1;.0021;.001;;6.23;125;.004;.0021;;;8.23453;25;.004;.0021;;2;15;.0344;.00221;;14;1.9;.004;.023021;;;8;1.9;.004;.023021;;1;1.9;.004;.023021;;4;1.9;.004;.023021]]
        errors_2 = [.0001122;.00021;.00310102]
        trackedInterval_2 = TrackedInterval([-3;4;;4;19;;-2e-16;-1e-16])
        trackedInterval_2.reducedDims = []
        trackedInterval_2.solvedVals = []
        dim_2 = 2

        expected_new_Ms_2 = [[2.70019999999999971152; 15.89019999999999832596; 0.80019999999999980034;;4.00880199999999931038; 38.00019999999999953388; 3.83900200000000069167;;48.09680000000000177351; -90.05339799999998717794; 71.84699999999999420197],[5.86699999999999999289; 13.23314399999999935176; 5.89440000000000008384;;3.19770000000000020890; 56.19767000000000223281; 5.18700000000000027711;;5.18700000000000027711; 3.19770000000000020890; 5.18700000000000027711]]
        expected_new_errors_2 = [0.00011220000000000000; 0.00021000000000000001]
        expected_new_trackedInterval_2 = [-3.;4.;;4.;19.]

        new_Ms_2, new_errors_2, new_trackedInterval_2 = reduceSolvedDim(Ms_2,errors_2,trackedInterval_2,dim_2)
        @test isapprox(expected_new_Ms_2[1],new_Ms_2[1])
        @test isapprox(expected_new_Ms_2[2],new_Ms_2[2])
        @test isapprox(expected_new_errors_2,new_errors_2)
        @test isapprox(expected_new_trackedInterval_2,new_trackedInterval_2.interval)
        @test (2 == new_trackedInterval_2.ndim)
        @test ([2] == new_trackedInterval_2.reducedDims)
        @test ([-0.00000000000000015000] == new_trackedInterval_2.solvedVals)
    end
end

function test_transformChebInPlace1D()
    @testset "transformChebInPlace1D unit tests" begin
        alpha_1 = 0.8043138619259216
        beta_1 = 0.19568613807407842
        coeffs_1 = [1.6668764854819471; 0.502737971117991; 0.003441591526151544;;0.5575078290711436; 0; 0;;0.01239107183457752; 0.0; 0.0;;;
                            -1.20687653838567; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0;;;
                            -0.018876295666785736; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0]
        expected_transformed_coeffs_1 = [ 1.43592664172332273864;  0.50273797111799101156;  0.00344159152615154413;;
                                                    0.55750782907114360132;  0.;          0.;;
                                                    0.01239107183457751997;  0.;0.;;;
                                                    -0.98259152221737600108;  0.;0.;;
                                                    0.;0.;0.;;
                                                    0.;          0.;          0.;;;
                                                    -0.01221146807645548740;  0.;          0.;;
                                                    0.;          0.;          0.;;
                                                    0.;          0.;          0.]
        transformed_coeffs_1 = transformChebInPlace1D(coeffs_1,alpha_1,beta_1)
        @test isapprox(expected_transformed_coeffs_1,transformed_coeffs_1)

        alpha_2 = 0.561531793052032
        beta_2 = -0.43846820694796795
        coeffs_2 = [2.071105809166741; -1.20687653838567; -0.018876295666785736;;0.5575078290711436; 0; 0;;0.01239107183457752; 0.0; 0.0;;;
                        0.9144403736144754; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0;;;
                        0.010914670337842268; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0]
        expected_transformed_coeffs_2 = [ 1.66687648548194711218; -1.20687653838567010567; -0.01887629566678573553 ;;
                                                0.55750782907114360132;  0.;          0.;;
                                                0.01239107183457751997;  0.;          0.;;;
                                                0.50273797111799101156;  0.;          0.;;
                                                0.;          0.;          0.;;
                                                0.;          0.;          0.;;;
                                                0.00344159152615154413;  0.;          0.;;
                                                0.;          0.;          0.;;
                                                0.;          0.;          0.]
        transformed_coeffs_2 = transformChebInPlace1D(coeffs_2,alpha_2,beta_2)
        @test isapprox(transformed_coeffs_2,expected_transformed_coeffs_2)
        
        alpha_3 = 0.561531793052032
        beta_3 = 0
        coeffs_3 = np.array[2.071105809166741; -1.20687653838567; -0.018876295666785736;;0.5575078290711436; 0; 0;;0.01239107183457752; 0.0; 0.0;;;
                        0.9144403736144754; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0;;;
                        0.010914670337842268; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0]
        expected_transformed_coeffs_3 = [ 2.06363273035505034869; -1.20687653838567010567; -0.01887629566678573553 ;;
                                                 0.55750782907114360132;  0.;          0.;;        
                                                 0.01239107183457751997;  0.;          0.;;;        
                                                 0.51348734263490647400;  0.;          0.;;
                                                 0.;          0.;          0.;;
                                                 0.;          0.;          0.;;;
                                                 0.00344159152615154413;  0.;          0.;;
                                                 0.;          0.;          0.;;
                                                 0.;          0.;          0.]
        transformed_coeffs_3 = transformChebInPlace1D(coeffs_3,alpha_3,beta_3)
        @test isapprox(transformed_coeffs_3,expected_transformed_coeffs_3)
        
        alpha_4 = 0
        beta_4 = -0.43846820694796795
        coeffs_4 = [2.071105809166741; -1.20687653838567; -0.018876295666785736;;0.5575078290711436; 0; 0;;0.01239107183457752; 0.0; 0.0;;;
                        0.9144403736144754; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0;;;
                        0.010914670337842268; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0]
        expected_transformed_coeffs_4 = [ 1.66343489395579569035; -1.20687653838567010567; -0.01887629566678573553;;
                                                 0.55750782907114360132;  0.;          0.;;
                                                 0.01239107183457751997;  0.;          0.;;;    
                                                 0.;          0.;          0.;;        
                                                 0.;          0.;          0.;;        
                                                 0.;          0.;          0.]
        transformed_coeffs_4 = transformChebInPlace1D(coeffs_4,alpha_4,beta_4)
        @test isapprox(transformed_coeffs_4,expected_transformed_coeffs_4)
        
        alpha_5 = 0
        beta_5 = 0
        coeffs_5 = [2.071105809166741; -1.20687653838567; -0.018876295666785736;;0.5575078290711436; 0; 0;;0.01239107183457752; 0.0; 0.0;;;
                        0.9144403736144754; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0;;;
                        0.010914670337842268; 0; 0;;0; 0; 0;;0.0; 0.0; 0.0]
        expected_transformed_coeffs_5 = np.array[ 2.06019113882889870482; -1.20687653838567010567; -0.01887629566678573553;;
                                                     0.55750782907114360132;  0.;          0.;;        
                                                     0.01239107183457751997;  0.;          0.;;;
                                                     0.;          0.;          0.;;        
                                                     0.;          0.;          0.;;        
                                                     0.;          0.;          0.]
        transformed_coeffs_5 = transformChebInPlace1D(coeffs_5,alpha_5,beta_5)
        @test isapprox(transformed_coeffs_5,expected_transformed_coeffs_5)
        
        alpha_6 = 1.000000082740371e-10
        beta_6 = -0.7266187050359711
        coeffs_6 = [10.1; 13.9]
        expected_transformed_coeffs_6 = [0.00000000000000000000; 0.00000000139000011501]
        transformed_coeffs_6 = transformChebInPlace1D(coeffs_6,alpha_6,beta_6)
        @test isapprox(transformed_coeffs_6,expected_transformed_coeffs_6)

        alpha_7 = 7.667826729776448e-06
        beta_7 = 0.0
        coeffs_7 = [0; 1.39000012e-09]
        expected_transformed_coeffs_7 = [0.00000000000000000000; 0.00000000000001065828]
        transformed_coeffs_7 = transformChebInPlace1D(coeffs_7,alpha_7,beta_7)
        @test isapprox(transformed_coeffs_7,expected_transformed_coeffs_7)

        alpha_8 = 0
        beta_8 = -0.7266187050359711
        coeffs_8 = [10.1; 13.9]
        expected_transformed_coeffs_8 = [0.0;0.0]
        transformed_coeffs_8 = transformChebInPlace1D(coeffs_8,alpha_8,beta_8)
        @test isapprox(transformed_coeffs_8,expected_transformed_coeffs_8)

        alpha_9 = 0
        beta_9 = 0
        coeffs_9 = [10.1; 13.9]
        expected_transformed_coeffs_9 = [10.09999999999999964473; 0.00000000000000000000]
        transformed_coeffs_9 = transformChebInPlace1D(coeffs_9,alpha_9,beta_9)
        @test isapprox(transformed_coeffs_9,expected_transformed_coeffs_9)

        alpha_10 = 0.5197277737990523
        beta_10 = -0.48027222620094767
        coeffs_10 = [-1.27278454e-02; 7.67937509e-02; -6.13381857e-02; -5.38708766e-02;
                    1.41766096e-02;  6.52808648e-03; -1.07489381e-03; -3.41236334e-04;
                    4.12240520e-05;  1.00310107e-05; -9.59578551e-07; -1.89618788e-07;
                    1.50313164e-08;  2.50245049e-09; -1.69453828e-10; -2.43827788e-11;
                    1.44149276e-12;  1.82690668e-13; -9.54097912e-15; -1.06772230e-15;;
                    4.65987370e-02;  1.23340236e-01;  2.24569195e-01; -8.65232725e-02;
                    -5.19029012e-02;  1.04849121e-02;  3.93536318e-03; -5.48067641e-04;
                    -1.50928040e-04;  1.61110404e-05;  3.51317503e-06; -3.04551162e-07;
                    -5.50321239e-08;  4.01924410e-09;  6.20398379e-10; -3.91616600e-11;
                    -5.27744515e-12;  2.93404190e-13;  3.50275364e-14; -1.80758186e-15;;
                    -2.87478641e-02;  1.73450906e-01; -1.38542053e-01; -1.21675947e-01;
                    3.20201285e-02;  1.47447221e-02; -2.42781871e-03; -7.70736558e-04;
                    9.31110811e-05;  2.26566338e-05; -2.16736085e-06; -4.28284206e-07;
                    3.39506200e-08;  5.65218263e-09; -3.82738438e-10; -5.50723391e-11;
                    3.25587474e-12;  4.12628265e-13; -2.15105711e-14; -2.44249065e-15;;
                    3.73393021e-02;  9.88318274e-02;  1.79946014e-01; -6.93306046e-02;
                    -4.15894986e-02;  8.40150023e-03;  3.15338406e-03; -4.39163474e-04;
                    -1.20937778e-04;  1.29096848e-05;  2.81508711e-06; -2.44035109e-07;
                    -4.40969270e-08;  3.22059738e-09;  4.97121667e-10; -3.13800270e-11;
                    -4.22882562e-12;  2.35075848e-13;  2.80678258e-14; -1.43982049e-15;;
                    -3.66618631e-02;  2.21200203e-01; -1.76681292e-01; -1.55172117e-01;
                    4.08349492e-02;  1.88037964e-02; -3.09617289e-03; -9.82912613e-04;
                    1.18743629e-04;  2.88937782e-05; -2.76401358e-06; -5.46186558e-07;
                    4.32968857e-08;  7.20817194e-09; -4.88102510e-10; -7.02331179e-11;
                    4.15216472e-12;  5.26217958e-13; -2.73947531e-14; -3.13638004e-15;;
                    1.37223730e-02;  3.63211715e-02;  6.61310250e-02; -2.54793303e-02;
                    -1.52843406e-02;  3.08759170e-03;  1.15888380e-03; -1.61394687e-04;
                    -4.44452144e-05;  4.74437119e-06;  1.03455804e-06; -8.96840750e-08;
                    -1.62058325e-08;  1.18358501e-09;  1.82694606e-10; -1.15323194e-11;
                    -1.55412488e-12;  8.64031069e-14;  1.02730324e-14; -5.11743425e-16;;
                    -4.15092509e-02;  2.50447030e-01; -2.00041882e-01; -1.75688789e-01;
                    4.62340975e-02;  2.12900119e-02; -3.50554517e-03; -1.11287215e-03;
                    1.34443770e-04;  3.27140791e-05; -3.12946816e-06; -6.18402694e-07;
                    4.90215483e-08;  8.16122781e-09; -5.52638865e-10; -7.95192454e-11;
                    4.70114225e-12;  5.95801186e-13; -3.09474668e-14; -3.58393870e-15;;
                    -2.63869241e-02; -6.98424389e-02; -1.27164182e-01;  4.89945258e-02;
                    2.93904514e-02; -5.93716905e-03; -2.22843228e-03;  3.10347880e-04;
                    8.54642636e-05; -9.12301123e-06; -1.98936471e-06;  1.72454640e-07;
                    3.11623999e-08; -2.27593059e-09; -3.51305767e-10;  2.21756120e-11;
                    2.98841507e-12; -1.66144876e-13; -1.97897254e-14;  1.02348685e-15;;
                    -2.84597065e-02;  1.71712301e-01; -1.37153360e-01; -1.20456314e-01;
                    3.16991710e-02;  1.45969266e-02; -2.40348319e-03; -7.63010990e-04;
                    9.21777712e-05;  2.24295324e-05; -2.14563605e-06; -4.23991249e-07;
                    3.36103120e-08;  5.59552731e-09; -3.78902054e-10; -5.45202668e-11;
                    3.22319255e-12;  4.08409417e-13; -2.11913820e-14; -2.48585874e-15;;
                    -6.30534116e-02; -1.66893421e-01; -3.03867760e-01;  1.17075866e-01;
                    7.02305513e-02; -1.41872832e-02; -5.32499570e-03;  7.41598093e-04;
                    2.04222871e-04; -2.18000772e-05; -4.75372693e-06;  4.12092494e-07;
                    7.44647469e-08; -5.43849621e-09; -8.39469898e-10;  5.29901747e-11;
                    7.14097531e-12; -3.97015754e-13; -4.72955008e-14;  2.39391840e-15;;
                    1.16324708e-02; -7.01847829e-02;  5.60593433e-02;  4.92346804e-02;
                    -1.29565525e-02; -5.96627104e-03;  9.82387080e-04;  3.11869100e-04;
                    -3.76762576e-05; -9.16772914e-06;  8.76995998e-07;  1.73299954e-07;
                    -1.37377023e-08; -2.28708639e-09;  1.54870351e-10;  2.22842899e-11;
                    -1.31743921e-12; -1.67012237e-13;  8.72912853e-15;  9.80118764e-16;;
                    -4.43198275e-02; -1.17308286e-01; -2.13586646e-01;  8.22918549e-02;
                    4.93645917e-02; -9.97214783e-03; -3.74290438e-03;  5.21264412e-04;
                    1.43546910e-04; -1.53231306e-05; -3.34136333e-06;  2.89657098e-07;
                    5.23407798e-08; -3.82268313e-09; -5.90057912e-10;  3.72464247e-11;
                    5.01934605e-12; -2.79096191e-13; -3.32095462e-14;  1.68962067e-15;;
                    4.60753373e-02; -2.77996619e-01;  2.22046821e-01;  1.95014847e-01;
                    -5.13199248e-02; -2.36319485e-02;  3.89116095e-03;  1.23528993e-03;
                    -1.49232808e-04; -3.63126820e-05;  3.47371484e-06;  6.86428015e-07;
                    -5.44139999e-08; -9.05897641e-09;  6.13429973e-10;  8.82664740e-11;
                    -5.21817312e-12; -6.61332100e-13;  3.44446693e-14;  3.94823063e-15;;
                    4.47229450e-02;  1.18375281e-01;  2.15529355e-01; -8.30403527e-02;
                    -4.98135946e-02;  1.00628510e-02;  3.77694853e-03; -5.26005650e-04;
                    -1.44852562e-04;  1.54625044e-05;  3.37175519e-06; -2.92291718e-07;
                    -5.28168532e-08;  3.85745291e-09;  5.95424767e-10; -3.75852752e-11;
                    -5.06502479e-12;  2.81580315e-13;  3.35634298e-14; -1.65839564e-15;;
                    4.99989117e-03; -3.01669596e-02;  2.40955357e-02;  2.11621459e-02;
                    -5.56901053e-03; -2.56443420e-03;  4.22251522e-04;  1.34048182e-04;
                    -1.61940822e-05; -3.94049113e-06;  3.76952122e-07;  7.44881225e-08;
                    -5.90476580e-09; -9.83039967e-10;  6.65666877e-11;  9.57826483e-12;
                    -5.66286601e-13; -7.17325505e-14;  3.70189990e-15;  4.41053444e-16;;
                    5.59958927e-02;  1.48213172e-01;  2.69856080e-01; -1.03971657e-01;
                    -6.23697008e-02;  1.25993117e-02;  4.72897311e-03; -6.58591601e-04;
                    -1.81364365e-04;  1.93600116e-05;  4.22164600e-06; -3.65967305e-07;
                    -6.61299662e-08;  4.82976958e-09;  7.45508688e-10; -4.70590684e-11;
                    -6.34175351e-12;  3.52551321e-13;  4.20080637e-14; -2.13370988e-15;;
                    -5.43412610e-02;  3.27869262e-01; -2.61882060e-01; -2.30000545e-01;
                    6.05267284e-02;  2.78715243e-02; -4.58923592e-03; -1.45690116e-03;
                    1.76005200e-04;  4.28271836e-05; -4.09689990e-06; -8.09573323e-07;
                    6.41758812e-08;  1.06841583e-08; -7.23479519e-10; -1.04101582e-10;
                    6.15428541e-12;  7.79959430e-13; -4.06896739e-14; -4.62130334e-15;;
                    -8.40268562e-02; -2.22407149e-01; -4.04943237e-01;  1.56018790e-01;
                    9.35913266e-02; -1.89063965e-02; -7.09624803e-03;  9.88275730e-04;
                    2.72153486e-04; -2.90514328e-05; -6.33495823e-06;  5.49166744e-07;
                    9.92339419e-08; -7.24750223e-09; -1.11870260e-09;  7.06163114e-11;
                    9.51624890e-12; -5.29076782e-13; -6.29774011e-14;  3.17107451e-15;;
                    4.65783526e-02; -2.81031573e-01;  2.24470958e-01;  1.97143870e-01;
                    -5.18801965e-02; -2.38899441e-02;  3.93364167e-03;  1.24877588e-03;
                    -1.50862017e-04; -3.67091161e-05;  3.51163821e-06;  6.93921911e-07;
                    -5.50080504e-08; -9.15787533e-09;  6.20127050e-10;  8.92301372e-11;
                    -5.27511368e-12; -6.68534672e-13;  3.48610030e-14;  3.97945565e-15;;
                    5.09954538e-02;  1.34977721e-01;  2.45757905e-01; -9.46869771e-02;
                    -5.68000802e-02;  1.14741919e-02;  4.30667533e-03; -5.99779304e-04;
                    -1.65168509e-04;  1.76311606e-05;  3.84465259e-06; -3.33286387e-07;
                    -6.02245535e-08;  4.39847063e-09;  6.78934693e-10; -4.28566072e-11;
                    -5.77546344e-12;  3.21145888e-13;  3.81500387e-14; -1.91860416e-15;;
                    -2.18748237e-02;  1.31982257e-01; -1.05419414e-01; -9.25856573e-02;
                    2.43647551e-02;  1.12195534e-02; -1.84737573e-03; -5.86468835e-04;
                    7.08500806e-05;  1.72398850e-05; -1.64918814e-06; -3.25890003e-07;
                    2.58337046e-08;  4.30085866e-09; -2.91233294e-10; -4.19056161e-11;
                    2.47740717e-12;  3.13971071e-13; -1.63896674e-14; -1.86656246e-15;;
                    -1.94614349e-02; -5.15116531e-02; -9.37887817e-02;  3.61354652e-02;
                    2.16766591e-02; -4.37890482e-03; -1.64355988e-03;  2.28894245e-04;
                    6.30333872e-05; -6.72859363e-06; -1.46723778e-06;  1.27192345e-07;
                    2.29835435e-08; -1.67859177e-09; -2.59102349e-10;  1.63554240e-11;
                    2.20410495e-12; -1.22533927e-13; -1.46133106e-14;  7.35522754e-16;;
                    6.99889336e-03; -4.22279857e-02;  3.37291511e-02;  2.96229652e-02;
                    -7.79555184e-03; -3.58971843e-03;  5.91071539e-04;  1.87641870e-04;
                    -2.26686242e-05; -5.51593550e-06;  5.27661025e-07;  1.04269155e-07;
                    -8.26554515e-09; -1.37606830e-09;  9.31806780e-11;  1.34078165e-11;
                    -7.92661076e-13; -1.00423142e-13;  5.20070098e-15;  6.04117451e-16;;
                    5.33566892e-03;  1.41227575e-02;  2.57137199e-02; -9.90712551e-03;
                    -5.94300864e-03;  1.20054798e-03;  4.50608672e-04; -6.27550802e-05;
                    -1.72816283e-05;  1.84475338e-06;  4.02267100e-07; -3.48718500e-08;
                    -6.30131230e-09;  4.60213227e-10;  7.10371188e-11; -4.48410710e-12;
                    -6.04214595e-13;  3.36380229e-14;  3.98379246e-15; -2.09901541e-16;;
                    -1.67122953e-03;  1.00834022e-02; -8.05400947e-03; -7.07351457e-03;
                    1.86145949e-03;  8.57170288e-04; -1.41138914e-04; -4.48060312e-05;
                    5.41292347e-06;  1.31712169e-06; -1.25997446e-07; -2.48978919e-08;
                    1.97368678e-09;  3.28584191e-10; -2.22501628e-11; -3.20155773e-12;
                    1.89271775e-13;  2.40042361e-14; -1.22384741e-15; -1.51788304e-16;;
                    -1.12379157e-03; -2.97451661e-03; -5.41578986e-03;  2.08662574e-03;
                    1.25170866e-03; -2.52857835e-04; -9.49066056e-05;  1.32173924e-05;
                    3.63983382e-06; -3.88539530e-07; -8.47249673e-08;  7.34466326e-09;
                    1.32717406e-09; -9.69295125e-11; -1.49617689e-11;  9.44391809e-13;
                    1.27321331e-13; -7.07940651e-15; -8.50665025e-16;  4.66206934e-17;;
                    3.13650769e-04; -1.89241920e-03;  1.51154956e-03;  1.32753356e-03;
                    -3.49352491e-04; -1.60870853e-04;  2.64884794e-05;  8.40904609e-06;
                    -1.01587937e-06; -2.47192995e-07;  2.36467793e-08;  4.67275305e-09;
                    -3.70414903e-10; -6.16675576e-11;  4.17581445e-12;  6.00883736e-13;
                    -3.55069706e-14; -4.50063164e-15;  2.76471554e-16;  1.49619900e-17;;
                    1.89522537e-04;  5.01639228e-04;  9.13349294e-04; -3.51900313e-04;
                    -2.11095196e-04;  4.26433691e-05;  1.60055843e-05; -2.22905548e-06;
                    -6.13842069e-07;  6.55254940e-08;  1.42884955e-08; -1.23864532e-09;
                    -2.23822115e-10;  1.63467490e-11;  2.52322006e-12; -1.59306040e-13;
                    -2.14301775e-14;  1.17625094e-15;  1.25767452e-16;  8.02309608e-18;;
                    -4.78699312e-05;  2.88824342e-04; -2.30695349e-04; -2.02610503e-04;
                    5.33187907e-05;  2.45523921e-05; -4.04271825e-06; -1.28340338e-06;
                    1.55045294e-07;  3.77270290e-08; -3.60901298e-09; -7.13163778e-10;
                    5.65334017e-11;  9.41182528e-12; -6.37325038e-13; -9.16781909e-14;
                    5.42811239e-15;  6.62149372e-16;  2.43403388e-17; -4.66206934e-18;;
                    -2.63362529e-05; -6.97083193e-05; -1.26919987e-04;  4.89004408e-05;
                    2.93340124e-05; -5.92576781e-06; -2.22415298e-06;  3.09751914e-07;
                    8.53001452e-08; -9.10549214e-09; -1.98554452e-09;  1.72123488e-10;
                    3.11025755e-11; -2.27155670e-12; -3.50589028e-13;  2.21502978e-14;
                    2.98681097e-15; -1.67753181e-16;  4.21483595e-18;  3.90312782e-18;;
                    6.08865033e-06; -3.67360133e-05;  2.93424970e-05;  2.57703422e-05;
                    -6.78169917e-06; -3.12285660e-06;  5.14199565e-07;  1.63238054e-07;
                    -1.97204499e-08; -4.79855896e-09;  4.59035895e-10;  9.07083746e-11;
                    -7.19054694e-12; -1.19703981e-12;  8.10918812e-14;  1.16999899e-14;
                    -7.13618482e-16; -8.31481422e-17;  1.95258035e-17;  1.14925430e-17;;
                    3.08026024e-06;  8.15301119e-06;  1.48444272e-05; -5.71934376e-06;
                    -3.43087502e-06;  6.93071526e-07;  2.60134577e-07; -3.62282557e-08;
                    -9.97661462e-09;  1.06496869e-09;  2.32227111e-10; -2.01313972e-11;
                    -3.63770033e-12;  2.65738594e-13;  4.10709088e-14; -2.56145791e-15;
                    -3.15545184e-16;  2.61013203e-17; -7.69360026e-18; -5.09575021e-18;;
                    -6.57525352e-07;  3.96719450e-06; -3.16875410e-06; -2.78299006e-06;
                    7.32369064e-07;  3.37243441e-07; -5.55294247e-08; -1.76283993e-08;
                    2.12965026e-09;  5.18205827e-10; -4.95722497e-11; -9.79580155e-12;
                    7.76543678e-13;  1.29308262e-13; -8.71592159e-15; -1.22439661e-15;
                    8.88524856e-17;  1.53778832e-18; -1.10160870e-17; -1.19262239e-17;;
                    -3.08270155e-07; -8.15947300e-07; -1.48561924e-06;  5.72387672e-07;
                    3.43359422e-07; -6.93620831e-08; -2.60340751e-08;  3.62569688e-09;
                    9.98452146e-10; -1.06581263e-10; -2.32411163e-11;  2.01471337e-12;
                    3.64069632e-13; -2.65750614e-14; -4.09980444e-15;  2.79946930e-16;
                    3.48510647e-17; -2.26034977e-17;  4.50250951e-18; -9.52742659e-18;;
                    6.11851039e-08; -3.69161747e-07;  2.94863990e-07;  2.58967256e-07;
                    -6.81495810e-08; -3.13817176e-08;  5.16721310e-09;  1.64038610e-09;
                    -1.98171638e-10; -4.82208876e-11;  4.61288656e-12;  9.11541933e-13;
                    -7.22717211e-14; -1.20474774e-14;  8.35252102e-16;  1.00545656e-16;
                    1.27374962e-17;  2.43358124e-17;  5.14101353e-18;  5.09575021e-18;;
                    2.67519968e-08;  7.08087345e-08;  1.28923545e-07; -4.96723829e-08;
                    -2.97970790e-08;  6.01931195e-09;  2.25926344e-09; -3.14641648e-10;
                    -8.66466843e-11;  9.24926549e-12;  2.01690985e-12; -1.74837705e-13;
                    -3.15909424e-14;  2.28338099e-15;  3.59473036e-16; -3.94246522e-17;
                    -4.72084946e-17;  1.26574516e-18;  2.64644989e-17;  1.08420217e-19;;
                    -4.96534422e-09;  2.99585198e-08; -2.39290467e-08; -2.10159252e-08;
                    5.53053126e-09;  2.54671512e-09; -4.19333965e-10; -1.33121984e-10;
                    1.60821871e-11;  3.91327100e-12; -3.74345797e-13; -7.39586235e-14;
                    5.84473205e-15;  9.70149653e-16; -6.10402796e-17; -4.65166581e-17;
                    -1.61687969e-17; -9.68862424e-18; -1.45891102e-17;  1.07336015e-17;;
                    -2.03529227e-09; -5.38712953e-09; -9.80850499e-09;  3.77907559e-09;
                    2.26696213e-09; -4.57949416e-10; -1.71884810e-10;  2.39379771e-11;
                    6.59204760e-12; -7.03709889e-13; -1.53466875e-13;  1.32700878e-14;
                    2.38268845e-15; -1.88327069e-16; -4.28491319e-17;  6.19072455e-18;
                    -1.32121341e-17;  1.12761857e-17; -3.40351561e-17; -1.03270257e-17;;
                    3.54967238e-10; -2.14170256e-09;  1.71066245e-09;  1.50240600e-09;
                    -3.95371913e-10; -1.82061995e-10;  2.99777427e-11;  9.51675183e-12;
                    -1.14972032e-12; -2.79794441e-13;  2.67499975e-14;  5.29835901e-15;
                    -4.46914871e-16; -8.83292958e-17; -2.25531774e-17; -2.49203076e-17;
                    2.09634645e-17;  1.83726977e-17; -3.60709593e-17;  5.85469173e-18;;
                    1.37012208e-10;  3.62651429e-10;  6.60290878e-10; -2.54400302e-10;
                    -1.52607803e-10;  3.08282569e-11;  1.15709698e-11; -1.61145100e-12;
                    -4.43780428e-13;  4.73708647e-14;  1.03369322e-14; -8.71307104e-16;
                    -1.84193320e-16; -8.70650111e-18; -1.59121392e-17;  2.92512807e-18;
                    -6.48292491e-19;  1.27092481e-17; -1.98229073e-17;  5.36680075e-18;;
                    -2.25462856e-11;  1.36032912e-10; -1.08655285e-10; -9.54272046e-11;
                    2.51126388e-11;  1.15638625e-11; -1.90406470e-12; -6.04429468e-13;
                    7.30174759e-14;  1.77450324e-14; -1.65464517e-15; -3.17499087e-16;
                    2.49848083e-17; -1.53803727e-17; -4.06793909e-17;  1.32805378e-17;
                    1.20796635e-17;  3.82887879e-17; -2.89131213e-17; -4.33680869e-18;;
                    -8.22612703e-12; -2.17733614e-11; -3.96434506e-11;  1.52740762e-11;
                    9.16251316e-12; -1.85088376e-12; -6.94710359e-13;  9.67497118e-14;
                    2.66375390e-14; -2.84884631e-15; -5.96123630e-16;  6.20434092e-17;
                    8.88472919e-18;  4.91247365e-18;  1.87918356e-17; -2.14266021e-17;
                    8.82289611e-18; -2.38437545e-17;  1.08430057e-17; -1.08420217e-18;;
                    1.28178750e-12; -7.73308193e-12;  6.17719864e-12;  5.42475225e-12;
                    -1.42763504e-12; -6.57348342e-13;  1.08245086e-13;  3.43597733e-14;
                    -4.17747029e-15; -9.93725456e-16;  8.73405181e-17;  2.26776801e-17;
                    1.79062347e-17; -5.97014386e-18;  2.58195826e-17;  2.79844237e-17;
                    -1.15790651e-17;  1.76807525e-17;  1.73942226e-17; -1.42030485e-17;;
                    4.43456578e-13;  1.17382615e-12;  2.13719783e-12; -8.23438555e-13;
                    -4.93952032e-13;  9.97903676e-14;  3.74798259e-14; -5.20882236e-15;
                    -1.42324671e-15;  1.21973853e-16;  4.62750811e-17;  3.78270524e-18;
                    -3.78281451e-18;  9.01908320e-18; -1.03887466e-17;  2.00346109e-17;
                    3.00580922e-17;  1.01088520e-17; -7.47030382e-18;  1.20346441e-17;;
                    -6.56681740e-14;  3.95864931e-13; -3.16551368e-13; -2.77678490e-13;
                    7.31438256e-14;  3.37027315e-14; -5.57876492e-15; -1.78908480e-15;
                    1.99466853e-16;  8.83116610e-17;  2.12951083e-17; -3.10712871e-17;
                    7.76068018e-18;  1.05960391e-18; -1.71968042e-18; -1.54783149e-17;
                    3.06399599e-17; -1.32173487e-17;  3.52209881e-17; -6.28837260e-18;;
                    -2.17006317e-14; -5.74776737e-14; -1.04599916e-13;  4.03179157e-14;
                    2.41529760e-14; -4.91423131e-15; -1.83970880e-15;  2.42273240e-16;
                    9.52277722e-17;  1.88663153e-17; -4.12873995e-18; -1.58428057e-17;
                    1.01037895e-17; -1.51542681e-17; -3.05459800e-17;  2.01218598e-17;
                    -3.91802196e-17;  1.98783667e-18;  2.34252406e-17; -7.91467586e-18;;
                    2.95369198e-15; -1.78146579e-14;  1.41804386e-14;  1.24857646e-14;
                    -3.32826425e-15; -1.54763729e-15;  2.41704017e-16;  6.29998429e-17;
                    3.42356256e-17; -3.03722802e-17; -1.96223880e-17; -4.31566314e-18;
                    -1.44600516e-17;  1.70077529e-17; -1.06254713e-17; -1.79694690e-17;
                    -5.40209546e-17; -3.08412860e-17;  9.51678124e-20;  1.61546124e-17;;
                    9.18210820e-16;  2.72974382e-15;  4.40756179e-15; -1.91607157e-15;
                    -1.04326463e-15;  2.39592143e-16;  4.27662140e-17; -2.65367529e-17;
                    -5.25857538e-18;  5.06907017e-18; -1.23852289e-17; -2.53777332e-17;
                    1.53689204e-17;  5.02569613e-19;  4.22516209e-18; -2.20401194e-17;
                    -3.32089439e-17; -2.88861646e-17;  3.50411152e-17;  2.92734587e-18]
        transformed_coeffs_10 = transformChebInPlace1D(coeffs_10,alpha_10,beta_10)
        @test ((20,48) == size(transformed_coeffs_10))
    end
end