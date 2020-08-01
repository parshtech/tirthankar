'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "deb217eabf1d4b92e6ce8cc7ee94033b",
"assets/assets/aarti.png": "ccfd92f0a8c94037afc99b40b72e6b5f",
"assets/assets/aarti_new.png": "1883ca69adaadf391a13698231e233a4",
"assets/assets/abhinandannath.png": "b7dfb43b3687e9de354a3efbc00a333a",
"assets/assets/Adinath.png": "3b0318021459dd43b6e7edb742358f49",
"assets/assets/ajitnath.png": "68be64949a4cd1ab0e19ce77c89e008c",
"assets/assets/applogo.png": "7d6e748ea7ddb25460107bae8b53bb02",
"assets/assets/apr_header.png": "f3e0b3e681f29f043ff7a9ea0803f8c6",
"assets/assets/apr_rashi.png": "8e7ff983802d1b4b9bf48ce4a90f06d5",
"assets/assets/apr_row_1_col_1.png": "1b2c7d74a1baea1c9b5f0715d5d0797f",
"assets/assets/apr_row_1_col_2.png": "bddd0f91e9752d0963a8ec9f692332af",
"assets/assets/apr_row_1_col_3.png": "fcddefc29d67de5884b8d04fac45adae",
"assets/assets/apr_row_1_col_4.png": "fba860a711abb86a1a0cb9c8cc2794cd",
"assets/assets/apr_row_1_col_5.png": "e4d49d263005c2874a5847cae2e38ed5",
"assets/assets/apr_row_2_col_1.png": "b9c42bd549b7445a26b814a25de9bd3c",
"assets/assets/apr_row_2_col_2.png": "c8fdd0172da5d1a39b10cafc88eae3c4",
"assets/assets/apr_row_2_col_3.png": "5c90ee9df1310e3dd07583dd351f0d9e",
"assets/assets/apr_row_2_col_4.png": "76df3d6c6827f881dfb50072720de498",
"assets/assets/apr_row_2_col_5.png": "a69dd3da57c8d6bbf6de0d735c42f9a1",
"assets/assets/apr_row_3_col_1.png": "80be26cc87590e2c6502895098e090a1",
"assets/assets/apr_row_3_col_2.png": "031a57f187e973af7ab794d9fcf1e885",
"assets/assets/apr_row_3_col_3.png": "3716a7f19544540da5632730fd092e8c",
"assets/assets/apr_row_3_col_4.png": "b09505fa3b33fd9dace9919c3e80fad0",
"assets/assets/apr_row_3_col_5.png": "1571a3cbc8dbb016a4cf545746991168",
"assets/assets/apr_row_4_col_1.png": "4e7dd622fd63b2c60b78303828386738",
"assets/assets/apr_row_4_col_2.png": "297f772b8a72c8a08d76b2cf90dd910c",
"assets/assets/apr_row_4_col_3.png": "e40cd8cc7fb7000d68ba8d40545a830a",
"assets/assets/apr_row_4_col_4.png": "66b2ea1af746a110f6b3faf951743e08",
"assets/assets/apr_row_4_col_5.png": "d4924868a1708e09a44edaf41332d88c",
"assets/assets/apr_row_5_col_1.png": "623ad089e4a31d73af59d3a9da3ae328",
"assets/assets/apr_row_5_col_2.png": "34511e1a501e045da7c90f89ccfb86c6",
"assets/assets/apr_row_5_col_3.png": "fb322f31cbdcbddb024e431b5c6e76a2",
"assets/assets/apr_row_5_col_4.png": "23863a0cba60030b16778a73648b2e99",
"assets/assets/apr_row_5_col_5.png": "e3e17553dfa4b4425689d3413cd46481",
"assets/assets/apr_row_6_col_1.png": "b5b05e8bbce201a02aa11dbe2787a98d",
"assets/assets/apr_row_6_col_2.png": "b6dbb100797fff8513191ba8a776af57",
"assets/assets/apr_row_6_col_3.png": "32396e7faf0bbf3a1151d0b7840a1a42",
"assets/assets/apr_row_6_col_4.png": "7a0ca50a652a4131bfd8bdbc406cb742",
"assets/assets/apr_row_6_col_5.png": "b06a11c8c718b8f7751967316567f710",
"assets/assets/apr_row_7_col_1.png": "8e4f2766b19c6a7197b9d2d431499825",
"assets/assets/apr_row_7_col_2.png": "d559ca260b0f039ff102f4b443dedfcd",
"assets/assets/apr_row_7_col_3.png": "bf7ee64f9bf14c833139098628815ce9",
"assets/assets/apr_row_7_col_4.png": "9d16b2ed490f5d5cb22a84fd884dc702",
"assets/assets/apr_row_7_col_5.png": "5b0761fde21b7b090168b9ce352ad01d",
"assets/assets/ArihantAarti.pdf": "a87c0c9e3be83f184709394c3d39baf4",
"assets/assets/aryanandi.png": "8927cc2601be0fc23d9b8d56dbfcdd63",
"assets/assets/aug_header.png": "6d3fa377f4ee0fd77071af41fde09edd",
"assets/assets/aug_rashi.png": "23b349ebdd4d3f7b19f8231f25acc534",
"assets/assets/aug_row_1_col_1.png": "11af91d4c01142c9e3c381157dc938fe",
"assets/assets/aug_row_1_col_2.png": "67942c4b4367d1b26bcbbe52865ac794",
"assets/assets/aug_row_1_col_3.png": "d0809196a5aa7bcbaa4857c8edadcc2f",
"assets/assets/aug_row_1_col_4.png": "4030b457b239799912aa572bb0447757",
"assets/assets/aug_row_1_col_5.png": "eb53a29ee4870b056590ea41346a9ee5",
"assets/assets/aug_row_2_col_1.png": "b915920aaacb7b648556ddea496d2ee6",
"assets/assets/aug_row_2_col_2.png": "168f88bae7f3e88a88b107ada7c4941f",
"assets/assets/aug_row_2_col_3.png": "caca66548e53fe71ec63c7ff6f9fe82c",
"assets/assets/aug_row_2_col_4.png": "53ba148f77e7ba8f2b41674a55e6779e",
"assets/assets/aug_row_2_col_5.png": "0b047f65740a322be611c0ec1c8bf388",
"assets/assets/aug_row_3_col_1.png": "51d0ab071f03b4f7965823c39911054a",
"assets/assets/aug_row_3_col_2.png": "eae2c3ded2cf1ce1ec5eef22a2112d81",
"assets/assets/aug_row_3_col_3.png": "932fae77a2228da47ce10b30edeb750b",
"assets/assets/aug_row_3_col_4.png": "8b2fcaa35f390578c216e621ff0b9983",
"assets/assets/aug_row_3_col_5.png": "11f1b26d915d7e03da4c6407ae378841",
"assets/assets/aug_row_4_col_1.png": "265062e21eee90fb9ddece352daad7d5",
"assets/assets/aug_row_4_col_2.png": "68e93e86e7023245cc488fd6e43138fd",
"assets/assets/aug_row_4_col_3.png": "cb66d97488083a193eec7818b7bb8303",
"assets/assets/aug_row_4_col_4.png": "3bbfdd88493b017aad6f41d496f3c62e",
"assets/assets/aug_row_4_col_5.png": "aad0c9c29abdc04ee64925c4da094128",
"assets/assets/aug_row_5_col_1.png": "82581df248f51580bcf6c0c9c06061e8",
"assets/assets/aug_row_5_col_2.png": "a2f72be738c9eb2e416e06d5c094c850",
"assets/assets/aug_row_5_col_3.png": "ec874c70ec14d3554bde1ea2d5e2aa46",
"assets/assets/aug_row_5_col_4.png": "4b26c3e28facf0c4d13292c0d0117d5f",
"assets/assets/aug_row_5_col_5.png": "6379c8feec4c36d9c1daa88bc752bfea",
"assets/assets/aug_row_6_col_1.png": "05d6b108fd830b8f18d52e7bd955ee72",
"assets/assets/aug_row_6_col_2.png": "57b678ce4b7bf17fb04fc37f4858c229",
"assets/assets/aug_row_6_col_3.png": "8376a5795edaf5494e0fc3f21f0b833d",
"assets/assets/aug_row_6_col_4.png": "63a4fdc2df9f5de1a70768d4f007b977",
"assets/assets/aug_row_6_col_5.png": "5516099581537e785d8e0f14abcefa99",
"assets/assets/aug_row_7_col_1.png": "7a6fc7a87cde245795aa1aabb1d4b35b",
"assets/assets/aug_row_7_col_2.png": "5a6acaba81ff1a8ac6121965ce7d44bc",
"assets/assets/aug_row_7_col_3.png": "afc106ec51784e38d6ef300d46795e0d",
"assets/assets/aug_row_7_col_4.png": "3725933ecab840c49437128ce14f8966",
"assets/assets/aug_row_7_col_5.png": "d2a1cca0d6daa1f72f96abe8f366a794",
"assets/assets/bhajan.png": "7efa802f50d261121e6b722871bbb13a",
"assets/assets/bhakt.png": "39dd870dfe5f18e4c779c922f5c52333",
"assets/assets/chalisa.png": "f2e560367dba192fe7249c97f85e6cab",
"assets/assets/dec_header.png": "0293153c7834de23a7f487ce3b310b24",
"assets/assets/dec_rashi.png": "25ca66d89af74d585ec9d003a32e08f4",
"assets/assets/dec_row_1_col_1.png": "c1a653580c0dad7bd4bc292bf677f472",
"assets/assets/dec_row_1_col_2.png": "27ef56d7b06b2046ccc43baf909982c6",
"assets/assets/dec_row_1_col_3.png": "879b356cf224d88566e4b71484b5ced7",
"assets/assets/dec_row_1_col_4.png": "a48d2ae6acfc944030b6995ebb9f78ec",
"assets/assets/dec_row_1_col_5.png": "dd8c6df842941d1a72aa63bcd735af71",
"assets/assets/dec_row_2_col_1.png": "1dcfa143f431e8948f74ffc584814e55",
"assets/assets/dec_row_2_col_2.png": "83bf866972861931e436fb92b0a566d9",
"assets/assets/dec_row_2_col_3.png": "95b121cb9802e72a486fb469cceb96ad",
"assets/assets/dec_row_2_col_4.png": "de411cfb05470bb81323d204376d749f",
"assets/assets/dec_row_2_col_5.png": "35f0f8b3530741aada86ba36b043bf6a",
"assets/assets/dec_row_3_col_1.png": "58e0e66fc3f8927ebd2315d21520e18d",
"assets/assets/dec_row_3_col_2.png": "e4cca976c888577bfcc3472d8f4c88ee",
"assets/assets/dec_row_3_col_3.png": "c9197dd6c0f86275910a6843fae72ae2",
"assets/assets/dec_row_3_col_4.png": "23bf8d6b34598ef9ce95e0dd5860ba10",
"assets/assets/dec_row_3_col_5.png": "ae46243c5ef9936e37b70fdcc9bae208",
"assets/assets/dec_row_4_col_1.png": "a8a2dca03976798f3e0672589f0205d5",
"assets/assets/dec_row_4_col_2.png": "18aafa4c28937002e773072a690ad43f",
"assets/assets/dec_row_4_col_3.png": "314572a16a69811f9f8d80da03603ed7",
"assets/assets/dec_row_4_col_4.png": "021977084b9c84f8fe937a2cdb777ee3",
"assets/assets/dec_row_4_col_5.png": "023e756fb625ff8ee3a83eed8e7bd713",
"assets/assets/dec_row_5_col_1.png": "7f252ffe2d4b5fe31995f30ee440717c",
"assets/assets/dec_row_5_col_2.png": "888d92af2a0158eca54e3a5721783b59",
"assets/assets/dec_row_5_col_3.png": "7b88137dd324ffa23bf3e1dc6bdd479e",
"assets/assets/dec_row_5_col_4.png": "41b44679d4ed89a97fc5554014bd44d3",
"assets/assets/dec_row_5_col_5.png": "773815f0f1928827f8546be98f9ff9d2",
"assets/assets/dec_row_6_col_1.png": "26e1ec72e2a0ca6de74dff4cf43f3bdf",
"assets/assets/dec_row_6_col_2.png": "9ed831412664b45c1d3bf3c780211088",
"assets/assets/dec_row_6_col_3.png": "78ed10fced2c21c6c2937e835d415ce7",
"assets/assets/dec_row_6_col_4.png": "84bf74ca8a99393993cb747fb410adc4",
"assets/assets/dec_row_6_col_5.png": "64e6e67f15fb4f3c044a920a5d38eb5a",
"assets/assets/dec_row_7_col_1.png": "cad25f7d437565ff9b7f3ef084d33dd6",
"assets/assets/dec_row_7_col_2.png": "6661f2c897c2ab6db35171aff235cb90",
"assets/assets/dec_row_7_col_3.png": "d796adc54254e0ded28f27b8930cb383",
"assets/assets/dec_row_7_col_4.png": "32c31e22a4f9358ef9540723c0cd0de8",
"assets/assets/dec_row_7_col_5.png": "be9d229c48eab162ed00efa1391de816",
"assets/assets/diya.png": "ef483a71540268aa8398d548d7ed2bf6",
"assets/assets/diya1.png": "c8dc0dba7f0ab332485cbc0e7d54eb3a",
"assets/assets/empty_cell_image.png": "6c8306c125f63e9fefb11feb77dd2580",
"assets/assets/favorite.png": "3fab8c5ee202784d7fc2477bb3d4074f",
"assets/assets/feb_header.png": "dc17037dca173bc981e1afa8bcec50e8",
"assets/assets/feb_rashi.png": "5f2f8bcfca12c88f81e4cb9887fd5c7a",
"assets/assets/feb_row_1_col_1.png": "10a518ae3e80677870c8767fef78c81d",
"assets/assets/feb_row_1_col_2.png": "2797d214dff7d89ac65859fbc99a323f",
"assets/assets/feb_row_1_col_3.png": "9f8294b32b84f8bbf7924ee6963c4eca",
"assets/assets/feb_row_1_col_4.png": "2306f0bc8d314aaf16b88bb3bf112f83",
"assets/assets/feb_row_1_col_5.png": "768fa53025e51b09f0070b031e56cd6c",
"assets/assets/feb_row_2_col_1.png": "1e2aec552df3467d669939eb943b6585",
"assets/assets/feb_row_2_col_2.png": "35f40d033af82b266d5258b8384848d7",
"assets/assets/feb_row_2_col_3.png": "afeef563943e97a832565a7934f26d91",
"assets/assets/feb_row_2_col_4.png": "9768e8827ed6d34584fdefba003ea3a4",
"assets/assets/feb_row_2_col_5.png": "3017260f1b18aa2517640b9e914171a2",
"assets/assets/feb_row_3_col_1.png": "17ceabe3b71ff1a767a783f3ba28f783",
"assets/assets/feb_row_3_col_2.png": "060594541d9ff582bdbf9f4ade15e528",
"assets/assets/feb_row_3_col_3.png": "64c6f45189b24177ce6922dd68e131c0",
"assets/assets/feb_row_3_col_4.png": "62c7611f5d905f13b0c73a893b38d891",
"assets/assets/feb_row_3_col_5.png": "40432cc4e133508c770ce058cfecfe7c",
"assets/assets/feb_row_4_col_1.png": "bf41fe24a6974a8ba17c814fd295ce8b",
"assets/assets/feb_row_4_col_2.png": "39a7031acd89e25576efd268a7b174c7",
"assets/assets/feb_row_4_col_3.png": "0561d4d618fbec687765b74c0cf2d3ed",
"assets/assets/feb_row_4_col_4.png": "ee01c4cfa7a1d7be192b1a8163d47e30",
"assets/assets/feb_row_4_col_5.png": "31841019da2fb413e8eeb2177c208dbe",
"assets/assets/feb_row_5_col_1.png": "b4c74daec6530cec6f380412220481b3",
"assets/assets/feb_row_5_col_2.png": "b97cfc8738245690630704d55d75201c",
"assets/assets/feb_row_5_col_3.png": "070cbc97aeafbb10a7bd981df3f7116d",
"assets/assets/feb_row_5_col_4.png": "19352808eb6ffaf7df16ec82a04702a8",
"assets/assets/feb_row_5_col_5.png": "7db578678843406e75b5949daae9285a",
"assets/assets/feb_row_6_col_1.png": "b4c74daec6530cec6f380412220481b3",
"assets/assets/feb_row_6_col_2.png": "dc8d5f709bd6e737788407735e770f4f",
"assets/assets/feb_row_6_col_3.png": "2ca6dd965fd535c1ecd4e46e7c7daf39",
"assets/assets/feb_row_6_col_4.png": "b6910bbd4b0c9680e74c5924687072dd",
"assets/assets/feb_row_6_col_5.png": "9f3ea937ee7359906fdd57bec7566058",
"assets/assets/feb_row_7_col_1.png": "b79f8db995e02431746479a4bf48ab64",
"assets/assets/feb_row_7_col_2.png": "05114e401251bf4ab4f22e80a60e0996",
"assets/assets/feb_row_7_col_3.png": "a3e9dbbbf4e931e6d784536259eb1437",
"assets/assets/feb_row_7_col_4.png": "45e55783714596c4796c75666922cef5",
"assets/assets/feb_row_7_col_5.png": "0e4111174766ab9c92378ee7db014f33",
"assets/assets/friday.png": "941e85c6be125140a9b21b5cb51ee29c",
"assets/assets/google.png": "1f9655fee2546b061704aaabc468bb6b",
"assets/assets/hukumchand.png": "75d7cdcae199ad2ec81798a27bdd0203",
"assets/assets/jainaarti.pdf": "fb4ca29b7c3759ccd240e12224fd94c8",
"assets/assets/jainaarti.sqlite": "d41959e609b2ddb0674513d2e3944846",
"assets/assets/jainrasoi.png": "9756589fdd80b4c2a80fc9c09ed1a9ad",
"assets/assets/Jain_Bhajan.pdf": "d462c22580ec2570baffcb5cadc5f10c",
"assets/assets/jan_header.png": "4f3b7f6b730d7a671b177b30df0a1f69",
"assets/assets/jan_rashi.png": "8c35ba0601511b78ea484a0bcfe6c5cd",
"assets/assets/jan_row_1_col_1.png": "58e7d346dfb5a660bef93f553615f2c7",
"assets/assets/jan_row_1_col_2.png": "7051300c0e122de40ad9b55a30978a13",
"assets/assets/jan_row_1_col_3.png": "92c1046ead54893e99ed075b1c19748b",
"assets/assets/jan_row_1_col_4.png": "8129d9a2de6d6f849a1c257d66ed407b",
"assets/assets/jan_row_1_col_5.png": "8b8abe84a469cd8e65c4592252c04ab1",
"assets/assets/jan_row_2_col_1.png": "97e469532a24eeac089a9ea0a6008a21",
"assets/assets/jan_row_2_col_2.png": "0e27dfa978d9904a8f7b613e2b99899a",
"assets/assets/jan_row_2_col_3.png": "2311a4e01c9aa93fe4b4a2a8ed6661cf",
"assets/assets/jan_row_2_col_4.png": "da8fe5514facc5360fa6faa06e5684d5",
"assets/assets/jan_row_2_col_5.png": "7ef73ab5fdfa0f9adc0b0dd0b57ec98a",
"assets/assets/jan_row_3_col_1.png": "361c5eaad55abf366d9499c509b07599",
"assets/assets/jan_row_3_col_2.png": "9eaff7c55c2d07869db6562f74ef0f58",
"assets/assets/jan_row_3_col_3.png": "572df05010672113bc4f30caffd83334",
"assets/assets/jan_row_3_col_4.png": "c760ccc73eb055a252758bccea67dd4a",
"assets/assets/jan_row_3_col_5.png": "154eb7db74fffc776cd7a43d6cd1866e",
"assets/assets/jan_row_4_col_1.png": "f551d6994315fa80b77fe8c220e3d2f8",
"assets/assets/jan_row_4_col_2.png": "d65b79f5d2b6c5517abb19915f2a0654",
"assets/assets/jan_row_4_col_3.png": "693bfb213489504156c5c00e058e929a",
"assets/assets/jan_row_4_col_4.png": "570f18c62e830f77287b3e649e9d677a",
"assets/assets/jan_row_4_col_5.png": "2dc886888698b0cfd3aef22e21c7e091",
"assets/assets/jan_row_5_col_1.png": "d074c4fd68511898439a8b654380e2b3",
"assets/assets/jan_row_5_col_2.png": "c14ea2ff76a37447774f5ca5b1cc882f",
"assets/assets/jan_row_5_col_3.png": "f7578f058b77c7124bb00755dc73a853",
"assets/assets/jan_row_5_col_4.png": "815727d45ef35d441ff3dd43cf905390",
"assets/assets/jan_row_5_col_5.png": "0db3e9d1772bb9777e62d3acbeb0ee29",
"assets/assets/jan_row_6_col_1.png": "96506ab42850af71fdbab8cf156e954c",
"assets/assets/jan_row_6_col_2.png": "37e3d7fe04d7e8cefd7a5176d4135da3",
"assets/assets/jan_row_6_col_3.png": "6675ec953fa093c6d3c4f50793072921",
"assets/assets/jan_row_6_col_4.png": "45cfae47b2d1b2c5884876fbde090322",
"assets/assets/jan_row_6_col_5.png": "c4ae6119dfe4614917a960b451a6d9eb",
"assets/assets/jan_row_7_col_1.png": "c24c6c957c7b3f1c9ce9992b2112670c",
"assets/assets/jan_row_7_col_2.png": "f62354234d809a8f2f4b7408e4ccce17",
"assets/assets/jan_row_7_col_3.png": "a5bc140c090d2747b2e1252b4445708b",
"assets/assets/jan_row_7_col_4.png": "d152342679691d45112da56b04899cf9",
"assets/assets/jan_row_7_col_5.png": "f87dee65e08c76ea7ec1ad3780baee03",
"assets/assets/jinvani.png": "64a0958ce4c8cffc4f0e431c378dd6c2",
"assets/assets/jul_header.png": "80955090c7df017e6d59a9554734f649",
"assets/assets/jul_rashi.png": "908cdd6712197e35e8cf6be56ad86d12",
"assets/assets/jul_row_1_col_1.png": "fa3c63dcdb3f68484f81187fe9c0b9c3",
"assets/assets/jul_row_1_col_2.png": "518786cca45d4f762c1da69cc3ba881e",
"assets/assets/jul_row_1_col_3.png": "c02d6b428f5eb0fae44fa5610373cef6",
"assets/assets/jul_row_1_col_4.png": "489a4f4b29e4339b6525f5679e709929",
"assets/assets/jul_row_1_col_5.png": "493f163b08eb54121a514a0602238531",
"assets/assets/jul_row_2_col_1.png": "a63d7ed7d26ca15454355271f2781499",
"assets/assets/jul_row_2_col_2.png": "ab1bd5623e6ac802bd22f1625dc83b2a",
"assets/assets/jul_row_2_col_3.png": "89f5996cd288704fa423a8672e5069c8",
"assets/assets/jul_row_2_col_4.png": "785360898ff82ed988462216f0265d08",
"assets/assets/jul_row_2_col_5.png": "12ef72439642faaac02423229aaa3f64",
"assets/assets/jul_row_3_col_1.png": "242f1e3722ae1ede9b4644280845e604",
"assets/assets/jul_row_3_col_2.png": "24fe0eff30c10b579a5b1df665e69c16",
"assets/assets/jul_row_3_col_3.png": "456b17b87b4ff72eb8142eb12fc1474b",
"assets/assets/jul_row_3_col_4.png": "766c97216ba4eba97866994f7cc15bec",
"assets/assets/jul_row_3_col_5.png": "708f6a0819c2ae654ec5ae16bdc179f6",
"assets/assets/jul_row_4_col_1.png": "3e956dccc9cddec21f10a15c9f57bb02",
"assets/assets/jul_row_4_col_2.png": "405a24fe939dd39fc9db100cc0c399ef",
"assets/assets/jul_row_4_col_3.png": "2a45a60b8f976b35e85087cac7c950f1",
"assets/assets/jul_row_4_col_4.png": "732e0a3a4ecf45b795b644d5e1ae7548",
"assets/assets/jul_row_4_col_5.png": "5ae3bf22c178d445cdf3b06f7cdc4d54",
"assets/assets/jul_row_5_col_1.png": "50ee53b847348339894bb80c5b5521b2",
"assets/assets/jul_row_5_col_2.png": "1c91a98a1272eb181f85a7b68684beaf",
"assets/assets/jul_row_5_col_3.png": "6eb76bc877e97b58eda2abb534ec5b06",
"assets/assets/jul_row_5_col_4.png": "cf80dc34740f1f894faa8d0e480e54ff",
"assets/assets/jul_row_5_col_5.png": "f000e1580ca3c92c2f277b20df3db0c3",
"assets/assets/jul_row_6_col_1.png": "4664f3057bec63d419f5f200cd7894e1",
"assets/assets/jul_row_6_col_2.png": "c62a9849a0b06271d173023e11a667e2",
"assets/assets/jul_row_6_col_3.png": "68a53aa41847d9ce84aac7cf5656ab40",
"assets/assets/jul_row_6_col_4.png": "d79a18823857c659424af6955aefff79",
"assets/assets/jul_row_6_col_5.png": "96b4d95c53b1f7a214521e895a044203",
"assets/assets/jul_row_7_col_1.png": "562afcd13469e3273a4a5df7dcbb77be",
"assets/assets/jul_row_7_col_2.png": "10e1a1dd744a55ea8b66c9cc85edbc26",
"assets/assets/jul_row_7_col_3.png": "c56881152b50d5fdc1eeb063818450ca",
"assets/assets/jul_row_7_col_4.png": "c908ebc15a6ce4e4db4810d44c27b3a2",
"assets/assets/jul_row_7_col_5.png": "5b46b93f0dc43ae742204ebd25a77888",
"assets/assets/jun_header.png": "65cc7bd283e4111937c796679404e448",
"assets/assets/jun_rashi.png": "df3f594e184263c1846e63a6e6e2fe96",
"assets/assets/jun_row_1_col_1.png": "49d274a7803676df0b1474140096c445",
"assets/assets/jun_row_1_col_2.png": "38380622e7836d3820801c09c2d0bcfd",
"assets/assets/jun_row_1_col_3.png": "52c3671088727171e647e60d41f28135",
"assets/assets/jun_row_1_col_4.png": "ccdeddb4031d76b2727528474ea9cff9",
"assets/assets/jun_row_1_col_5.png": "6a6bb53980324bb40f6c3e737165a754",
"assets/assets/jun_row_2_col_1.png": "6a1eafbd13171fde288470290449e649",
"assets/assets/jun_row_2_col_2.png": "6e202c234341f238470a2f5f8768e790",
"assets/assets/jun_row_2_col_3.png": "aea599b858a85e2cd3a6f2f9d66c6c0f",
"assets/assets/jun_row_2_col_4.png": "d1ab339bcb6951635b6f1421d35e6f6d",
"assets/assets/jun_row_2_col_5.png": "74be148f30f27c5d316f3e3f7138153d",
"assets/assets/jun_row_3_col_1.png": "2659cfdd4973975201ce06748aae04f8",
"assets/assets/jun_row_3_col_2.png": "6a5fb2b88bb9131b2a4dabbdca1da45a",
"assets/assets/jun_row_3_col_3.png": "adfa68ee2bebbc7dcf09883cb5a70be1",
"assets/assets/jun_row_3_col_4.png": "434ca69499cd02736dea606a173e1a3b",
"assets/assets/jun_row_3_col_5.png": "0e1d215a3d6714e196970d5e42817a38",
"assets/assets/jun_row_4_col_1.png": "d1905c6a2a44ec34dc8afaa75fa6706f",
"assets/assets/jun_row_4_col_2.png": "a68f14d58a0b12d7d87801fd0f36e7f8",
"assets/assets/jun_row_4_col_3.png": "ae3dea266220987d3ed02946f79c3983",
"assets/assets/jun_row_4_col_4.png": "622e31a5814da58d4ed18188bf45cf17",
"assets/assets/jun_row_4_col_5.png": "9720b27fba6d91865b14d5984007aca8",
"assets/assets/jun_row_5_col_1.png": "c3add496e8a34d5b65821d8e0df106d8",
"assets/assets/jun_row_5_col_2.png": "4525db1e68a7454a6273519f0d26f914",
"assets/assets/jun_row_5_col_3.png": "465b7eea68d50aefa36d1853d26a389e",
"assets/assets/jun_row_5_col_4.png": "569b449b7970bcc7328adf215c3ddbff",
"assets/assets/jun_row_5_col_5.png": "f62838af44465ca1a7ea6d2b22923e3f",
"assets/assets/jun_row_6_col_1.png": "12b7bfa5fac566abaeb252d3e485c4e5",
"assets/assets/jun_row_6_col_2.png": "bf2d6b7fc10a386e5270c7d46338e9fd",
"assets/assets/jun_row_6_col_3.png": "747657729761a5532d428067f7241b0d",
"assets/assets/jun_row_6_col_4.png": "a93a69889bcdce683251abc8beeccc28",
"assets/assets/jun_row_6_col_5.png": "955375be02b1458c971fe50767d5d98d",
"assets/assets/jun_row_7_col_1.png": "c6e25f33e917c427e7b55fc84ed617f6",
"assets/assets/jun_row_7_col_2.png": "1ea58a4595de0ce372f8f8a1fcb65f23",
"assets/assets/jun_row_7_col_3.png": "b957cda455df471431a5a01f401af19c",
"assets/assets/jun_row_7_col_4.png": "78e4b46c94d06d691c557f41e152061a",
"assets/assets/jun_row_7_col_5.png": "dfefabe21ce1eb5b9daad877d555eed9",
"assets/assets/kids.jpg": "004f0dcbdcd4a6df132a872a12605a1c",
"assets/assets/logo.jpg": "ac351fe05c0ab9353b10e55d0b24294e",
"assets/assets/mar_header.png": "57616df5e6f928eb42afd1b1cbc15ebb",
"assets/assets/mar_rashi.png": "73a72e1182f34759153390825477ad06",
"assets/assets/mar_row_1_col_1.png": "be3d7d11088e2668fe1122e3531f82fe",
"assets/assets/mar_row_1_col_2.png": "f5731c7bb481864e261152c2435972eb",
"assets/assets/mar_row_1_col_3.png": "91e3427bae10852cfa0158902f226901",
"assets/assets/mar_row_1_col_4.png": "39147a2a9914009ad476b27a6f388709",
"assets/assets/mar_row_1_col_5.png": "fb4ce7035ea14c3dd736edae05fe520c",
"assets/assets/mar_row_2_col_1.png": "78107e9c5d29670a2826a6a3975590d3",
"assets/assets/mar_row_2_col_2.png": "fe09c9bf7795b90a0173fc2e795a2d29",
"assets/assets/mar_row_2_col_3.png": "f776030bcb9187e447722bf5ec50f334",
"assets/assets/mar_row_2_col_4.png": "6c5377c4166216c6e9776bf289b12aaf",
"assets/assets/mar_row_2_col_5.png": "1930e2a516ae4aff03db71fe050da26c",
"assets/assets/mar_row_3_col_1.png": "e1ec1250988dd0daf4e2bb1b47b55681",
"assets/assets/mar_row_3_col_2.png": "55911d21b870ee807340f7fc05d408c1",
"assets/assets/mar_row_3_col_3.png": "c3facb4e1aaffaaedd8ce622d4a60e7e",
"assets/assets/mar_row_3_col_4.png": "32b8c5b40bf88f207a0a7994f3b216df",
"assets/assets/mar_row_3_col_5.png": "d3302710d6e8cd446a9f05939515ce70",
"assets/assets/mar_row_4_col_1.png": "d0eab777f549de77549d8d574527f76c",
"assets/assets/mar_row_4_col_2.png": "4dcaa86ec536f9d416bb3d48d375353d",
"assets/assets/mar_row_4_col_3.png": "d444084dcf8291c1a40de21dca7a8b58",
"assets/assets/mar_row_4_col_4.png": "5197352ccd39ac35f6d8fad97ee04f54",
"assets/assets/mar_row_4_col_5.png": "5946978cd08048152f55a97f66a9ebec",
"assets/assets/mar_row_5_col_1.png": "fb1d1f2855fb3947a0f80ae05d8dbae5",
"assets/assets/mar_row_5_col_2.png": "d877afbbcec88ee541d38cf27faddc4b",
"assets/assets/mar_row_5_col_3.png": "f5126952e54ab9d1adf135bea75e4382",
"assets/assets/mar_row_5_col_4.png": "b657a1fdfafdc7fb9fc47b8763d5d703",
"assets/assets/mar_row_5_col_5.png": "5ad4ffb1aa804be06576154ab5630c9f",
"assets/assets/mar_row_6_col_1.png": "416d04b07866981505a217d491f505ae",
"assets/assets/mar_row_6_col_2.png": "003a0673795d689bc76430c9bd40a1ee",
"assets/assets/mar_row_6_col_3.png": "955c4054f9efef901b32197b329d6652",
"assets/assets/mar_row_6_col_4.png": "805a3699a06aa40830cc287c98e896dd",
"assets/assets/mar_row_6_col_5.png": "8cc7581dfdc490cc6a9e5d276feb389e",
"assets/assets/mar_row_7_col_1.png": "68aa124887a03b7521101d1d6950e855",
"assets/assets/mar_row_7_col_2.png": "df35010e9298a1b457917685b6507c52",
"assets/assets/mar_row_7_col_3.png": "59bf86bf4ad0811cef4f681dcb820ee9",
"assets/assets/mar_row_7_col_4.png": "6a4ed8eff388fd724af4692c069017a0",
"assets/assets/mar_row_7_col_5.png": "4ae54817552f3b6abb0d264f7f5e0e96",
"assets/assets/may_header.png": "dfcb7284962aaf23e5c34903b9c17a42",
"assets/assets/may_rashi.png": "770bf17fbe4defbe49a2b4ebb961adfb",
"assets/assets/may_row_1_col_1.png": "e82089e3c6cc69098c8716085b6d1b71",
"assets/assets/may_row_1_col_2.png": "1d1f2a1854850d783b6ef26285513b62",
"assets/assets/may_row_1_col_3.png": "53547e69e5047cb59bf6c4fae4a494f3",
"assets/assets/may_row_1_col_4.png": "2364c9a29c9b771833178c4607efc5da",
"assets/assets/may_row_1_col_5.png": "9483265a42d6147bb3e05948f0dc5993",
"assets/assets/may_row_2_col_1.png": "c39984708b974e67d5dec6884b044d61",
"assets/assets/may_row_2_col_2.png": "bcc89d5cb7decc23a8ad1fda038378dc",
"assets/assets/may_row_2_col_3.png": "170ddf217d6d04c723f719ddb00de3df",
"assets/assets/may_row_2_col_4.png": "c12e3ab2a30c8393f4fd98665178ac56",
"assets/assets/may_row_2_col_5.png": "0992ab32e3030620fb7975129ea1a1d2",
"assets/assets/may_row_3_col_1.png": "c2d1c070d5defbdd67ff68f8518f3aac",
"assets/assets/may_row_3_col_2.png": "79590889935a13ee5d9971fd90c1455b",
"assets/assets/may_row_3_col_3.png": "b0ffe2ca4b52e79d53f316d9ea17cfee",
"assets/assets/may_row_3_col_4.png": "547770c0dd52186b2feb157036988700",
"assets/assets/may_row_3_col_5.png": "207129f00141075496456a011f002be6",
"assets/assets/may_row_4_col_1.png": "e1c002b793556cc53d9f5b7f3d0a5914",
"assets/assets/may_row_4_col_2.png": "1fa070db056798b965cc8f0642434bf4",
"assets/assets/may_row_4_col_3.png": "e58068a5238e3ebc287de12a03eea148",
"assets/assets/may_row_4_col_4.png": "01796059b118d8f882c197e4c918ecae",
"assets/assets/may_row_4_col_5.png": "27c9f542b06347a263b68bbda4f560c6",
"assets/assets/may_row_5_col_1.png": "07289f48f9170b4cc1eee12e0fb6d359",
"assets/assets/may_row_5_col_2.png": "9fb4bcd6e5a4f2b9da329a9dff48f931",
"assets/assets/may_row_5_col_3.png": "4b122de4ccd2bfe8e0a3f0d0a65bc882",
"assets/assets/may_row_5_col_4.png": "f0f5ac4f51adc6a6bcaffda1a5072c9c",
"assets/assets/may_row_5_col_5.png": "e657b88ab958ab637674f2fc8003438c",
"assets/assets/may_row_6_col_1.png": "00c7de1c2052d196475a04ed50617f76",
"assets/assets/may_row_6_col_2.png": "44f2af227548e937d937beb04803d0c9",
"assets/assets/may_row_6_col_3.png": "728d778ded5774a839493b15998d9a18",
"assets/assets/may_row_6_col_4.png": "63b9743790152947e6759ed044d2290c",
"assets/assets/may_row_6_col_5.png": "dc1b387de98baaefa4552d794b985a81",
"assets/assets/may_row_7_col_1.png": "cf897809d65cf3c86cf9e42e08f943d4",
"assets/assets/may_row_7_col_2.png": "d1732e17074951e5ab9d69b9ca73b6d8",
"assets/assets/may_row_7_col_3.png": "e2d7718e63aa518458757ba70b9ae566",
"assets/assets/may_row_7_col_4.png": "b4893bd1a1b0d3d458c278c7480cf5af",
"assets/assets/may_row_7_col_5.png": "470222f82e8b29d64968ee4b77550b3e",
"assets/assets/monday.png": "7c78151f894d77b862edcd32cf0a1684",
"assets/assets/namokar.png": "fbde44aacf4df15d74a3c7fcb03dc35b",
"assets/assets/nov_header.png": "6c56178ba60f66c1a3be0ce897643af3",
"assets/assets/nov_rashi.png": "8c1c568caa2787df171ec5113c08feca",
"assets/assets/nov_row_1_col_1.png": "12d0531045c8974c9ec534d673b33ae0",
"assets/assets/nov_row_1_col_2.png": "edd11d011cfb8cb5920ddb0e8b1602dd",
"assets/assets/nov_row_1_col_3.png": "64ac5ab7838b37eeea7d63af42406afa",
"assets/assets/nov_row_1_col_4.png": "8d99744fd0a973af05e687c8f697cd22",
"assets/assets/nov_row_1_col_5.png": "4fae8ab23f2d4cc27f0d3d2dd7968391",
"assets/assets/nov_row_2_col_1.png": "da4c2e766414283349acc8ec906e5af8",
"assets/assets/nov_row_2_col_2.png": "072fb1aefa703bdf18e91fc60e0fac78",
"assets/assets/nov_row_2_col_3.png": "d29a972e252104c29785abea9aa52bfb",
"assets/assets/nov_row_2_col_4.png": "8482f6c459f9d9110e779218889d85cd",
"assets/assets/nov_row_2_col_5.png": "617413eb103dfd2041e33c6cccee8955",
"assets/assets/nov_row_3_col_1.png": "12a6ff3f723221957a9d60031b63bd40",
"assets/assets/nov_row_3_col_2.png": "4b3d164bdb79d55382b9f60f5bc93911",
"assets/assets/nov_row_3_col_3.png": "d07032888d573dc8964af2558ae214b8",
"assets/assets/nov_row_3_col_4.png": "1ecde610ac655f6e98ec158b9dc91e16",
"assets/assets/nov_row_3_col_5.png": "2e1d2357941be252d97bed990c4bbb63",
"assets/assets/nov_row_4_col_1.png": "5a76a6ba715687413833a6e38d904a9b",
"assets/assets/nov_row_4_col_2.png": "12f62719051d6d5adea9a54837376f5e",
"assets/assets/nov_row_4_col_3.png": "bb2095a2a857fdfd452324a3c12a4985",
"assets/assets/nov_row_4_col_4.png": "a254119da5def6eb939a7321a11e6ad4",
"assets/assets/nov_row_4_col_5.png": "b426d060875ff9cf359b24e997b69432",
"assets/assets/nov_row_5_col_1.png": "469103c2425b22a86611da5f94b0a8e3",
"assets/assets/nov_row_5_col_2.png": "ed1b1c2b811df6ebbebf948ddc5442f7",
"assets/assets/nov_row_5_col_3.png": "2d8484aab41c1426c04dddf1b6a81837",
"assets/assets/nov_row_5_col_4.png": "323f4d5a8dc4b9b00e6649a495a647b9",
"assets/assets/nov_row_5_col_5.png": "994b4faed5a292e511d92141c45c3489",
"assets/assets/nov_row_6_col_1.png": "5d361bdf39eb2a09c29f31d28052335c",
"assets/assets/nov_row_6_col_2.png": "1de701d05ef90a133f0e90286f99fde0",
"assets/assets/nov_row_6_col_3.png": "a7195080fb93257c4512061bb7ce8009",
"assets/assets/nov_row_6_col_4.png": "d022b6632a0f1a17400d0db870307971",
"assets/assets/nov_row_6_col_5.png": "0b16365c1df8e6b6a8298b0855d8c4f2",
"assets/assets/nov_row_7_col_1.png": "6fdef3e33f4c3a135b1a140bea4a9e0d",
"assets/assets/nov_row_7_col_2.png": "ef8ec0cb57dfb8c40077650867cc6579",
"assets/assets/nov_row_7_col_3.png": "2d4f90c6e4c84eb225070a77b991f885",
"assets/assets/nov_row_7_col_4.png": "8722c9791bb92a85110dc452b69f5c10",
"assets/assets/nov_row_7_col_5.png": "9b28af295101094c1f6a57f45a900e23",
"assets/assets/oct_header.png": "5c5d71f970ec9b649d3b849d93e58903",
"assets/assets/oct_rashi.png": "37ee62018b43850368c118f176a37c96",
"assets/assets/oct_row_1_col_1.png": "08f30d28f2d7c606a879f3dc397409a7",
"assets/assets/oct_row_1_col_2.png": "3ee651a46ac984b0f41e9994fed019a2",
"assets/assets/oct_row_1_col_3.png": "a61741b3a0837da5c9158ca75a417048",
"assets/assets/oct_row_1_col_4.png": "e13a8558326cd5b30e7beeae7d318733",
"assets/assets/oct_row_1_col_5.png": "6a07588191cf6a3d2248bc3d81381cf3",
"assets/assets/oct_row_2_col_1.png": "b2d87a63b8c9cf23aa0c765c4b2abade",
"assets/assets/oct_row_2_col_2.png": "01ad76fc855b1b2a914a58f171352a04",
"assets/assets/oct_row_2_col_3.png": "37aa68673b92b9d71acc9f95f328c2dc",
"assets/assets/oct_row_2_col_4.png": "82f79059ad35ed508bfdaba49ae65674",
"assets/assets/oct_row_2_col_5.png": "0700d091e0e943a77527b157ccf951be",
"assets/assets/oct_row_3_col_1.png": "9b0dc8bd585b251c770e17e036fc023e",
"assets/assets/oct_row_3_col_2.png": "4799f5ec240643c11d5f4173ba25b1f8",
"assets/assets/oct_row_3_col_3.png": "c27e61a5b21e5d46bb84673679272f82",
"assets/assets/oct_row_3_col_4.png": "a42b5734ba122a1a9b6e03e1ecf28a1c",
"assets/assets/oct_row_3_col_5.png": "088e31b8d1718689c87dcc077dbbb519",
"assets/assets/oct_row_4_col_1.png": "8bd809a07dbfda771253cd2b76adbe70",
"assets/assets/oct_row_4_col_2.png": "d352aaf233378b597fa2fd7f0b759e90",
"assets/assets/oct_row_4_col_3.png": "70f563b3eb9934e332d5c4c302c45658",
"assets/assets/oct_row_4_col_4.png": "4e96a0e907f4d3c369731c2083594b71",
"assets/assets/oct_row_4_col_5.png": "e866c7dd72b85d5f64b50598e75835d4",
"assets/assets/oct_row_5_col_1.png": "9f568053d1884ce93eb97cf38008152d",
"assets/assets/oct_row_5_col_2.png": "2426917bfee16f476257f2c10e3a6fcb",
"assets/assets/oct_row_5_col_3.png": "879b1cc8af1a88634b103089e188b0ee",
"assets/assets/oct_row_5_col_4.png": "c97191b19a069ba17827e69a5b954304",
"assets/assets/oct_row_5_col_5.png": "7b50e4070f9b4af3fc170977de7df24d",
"assets/assets/oct_row_6_col_1.png": "3cdb47b7c72cb37b76fc784b7d6eb539",
"assets/assets/oct_row_6_col_2.png": "c9c9d5f9a883d19663c3c76460f42c66",
"assets/assets/oct_row_6_col_3.png": "fe37b4d9e67229e3ec021e4d02d6adb9",
"assets/assets/oct_row_6_col_4.png": "00bf0fb6289c2c93132301891caf785e",
"assets/assets/oct_row_6_col_5.png": "1076bff68587274ecf872865d09d71d5",
"assets/assets/oct_row_7_col_1.png": "c5b7c9368f0f05607b2a4b11b6528292",
"assets/assets/oct_row_7_col_2.png": "c7b7c08415ad5c28146298146e64bf67",
"assets/assets/oct_row_7_col_3.png": "59965831ef5b4373daec45cbb652176e",
"assets/assets/oct_row_7_col_4.png": "7db20da571dea1a0a7e32b0e4c74e9ba",
"assets/assets/oct_row_7_col_5.png": "59f6d06dcdc69b73129088c2f3b78500",
"assets/assets/pramansagar.png": "5a8355becfae1a11c2db2e09779094b9",
"assets/assets/puja_new.png": "580064941c25f62a96b5a8fdb89bce77",
"assets/assets/pulaksagar.png": "ccbd3eaab1b725f03d2a99c9a200a347",
"assets/assets/pushpdantsagar.png": "712b9e514b30bff80cb6c804d48cff13",
"assets/assets/saturday.png": "682e9db06acf4635461d00fc88c3d1c4",
"assets/assets/sep_header.png": "8c309ba1b8368466b29a2d1da58c9606",
"assets/assets/sep_rashi.png": "b0e90f159c49909c9bd213dac4ff7e44",
"assets/assets/sep_row_1_col_1.png": "e2a3d2d7d8f1aebb82061119b61a147e",
"assets/assets/sep_row_1_col_2.png": "36d1a58ec85d0a43cddd9cfcd315a611",
"assets/assets/sep_row_1_col_3.png": "7c7b394980752dcb96d3456b35fff4be",
"assets/assets/sep_row_1_col_4.png": "7d576516279177c62fa31d69c5dba554",
"assets/assets/sep_row_1_col_5.png": "b9ac4514431d1c7c25ea10a0c843d367",
"assets/assets/sep_row_2_col_1.png": "74b1c044f34c88523ddb507b3fe766c3",
"assets/assets/sep_row_2_col_2.png": "525b599312d673b653091095fa16d255",
"assets/assets/sep_row_2_col_3.png": "408fc854b7cf7b7b6c0730d81a92f503",
"assets/assets/sep_row_2_col_4.png": "8e9d7f63793b00054e8bc6b9b870200b",
"assets/assets/sep_row_2_col_5.png": "c1c5e95dcef452f10d94f3b4b524a801",
"assets/assets/sep_row_3_col_1.png": "720a5337c961f4869338266ffe86aac9",
"assets/assets/sep_row_3_col_2.png": "98fcf08d990f93cea10e5ac0ccf0af16",
"assets/assets/sep_row_3_col_3.png": "87d71c859c643bc8394e90ba490f5002",
"assets/assets/sep_row_3_col_4.png": "e749fa7ac428a518d41fa7afc748f406",
"assets/assets/sep_row_3_col_5.png": "2a75ab6793896e498e4cb4df5d43a4c1",
"assets/assets/sep_row_4_col_1.png": "bad674d87cbf66143116dcc61c1cec96",
"assets/assets/sep_row_4_col_2.png": "aab970d7804a551ee0f5eddd3eb58ef2",
"assets/assets/sep_row_4_col_3.png": "bd65afda09d5c6a00095a31d5341d567",
"assets/assets/sep_row_4_col_4.png": "0c64b076ad9b8abd60f2e382f7becdd4",
"assets/assets/sep_row_4_col_5.png": "e263a19104bd6559da8d70cdf8087128",
"assets/assets/sep_row_5_col_1.png": "cbc84e6a82d6f96cbc05898ea3e89113",
"assets/assets/sep_row_5_col_2.png": "d58c26fbb5654e1fb5ccec97b141da24",
"assets/assets/sep_row_5_col_3.png": "6eb64edc415dd0e80f1784c892051f1d",
"assets/assets/sep_row_5_col_4.png": "e013720c43f828ae00d43792dfc45ebc",
"assets/assets/sep_row_5_col_5.png": "ef97d206edf7502b6f3a291cab999047",
"assets/assets/sep_row_6_col_1.png": "113cf63f504f52cf246ed9e1345da2cd",
"assets/assets/sep_row_6_col_2.png": "9bbb092678482a1e1cbad7ff618ef6b2",
"assets/assets/sep_row_6_col_3.png": "283199601092cdc25cb3f06928f911a2",
"assets/assets/sep_row_6_col_4.png": "9ca57c21929f7c769c7226bd6d8f385a",
"assets/assets/sep_row_6_col_5.png": "484d608a620ff733c865847cfc311c40",
"assets/assets/sep_row_7_col_1.png": "0b80fafef77557ef6b4bd04ebd97e5ae",
"assets/assets/sep_row_7_col_2.png": "63587bdcc0c4804c849bab47719eedfc",
"assets/assets/sep_row_7_col_3.png": "fc24f2bffc49ee2ea534b770df4aa7fd",
"assets/assets/sep_row_7_col_4.png": "01011dfa8d41d7d13f5a3931e6738d70",
"assets/assets/sep_row_7_col_5.png": "9ed9a8e98fec210b926db6ed7adf9f02",
"assets/assets/settings.png": "166ece9b41daf064ffd596de428e80b4",
"assets/assets/shantisagar.png": "f063f2150c53df5bf6bc592261570c9a",
"assets/assets/story.png": "628e5777e2c627ff2a5f7f8c96b3f57b",
"assets/assets/sunday.png": "c16db81feffa3d6f70d8e46f97ed5516",
"assets/assets/tarunsagar.png": "c23db547d07bb7665a8d21cc9f251545",
"assets/assets/thursday.png": "cc0bea6e236885bfda8236756a6d8b9c",
"assets/assets/tirthankar.png": "282e97a9f15fcf6c7bf3d6400600e7a7",
"assets/assets/tuesday.png": "451389d781fad87d193f6eae0743e03e",
"assets/assets/vidyasagar.png": "242595b85f38eb67d89eddc1660fabe6",
"assets/assets/wednesday.png": "0ac6a6a8bee82b175b37ef0eea39c5c5",
"assets/FontManifest.json": "6ec0de910cee9f0669833b008f3190d6",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/fonts/tirthankar.ttf": "92aa56b84a99cd8100183446c49ab61a",
"assets/NOTICES": "4aacfec316a4717ef56fecc0de203461",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/progress_dialog/assets/double_ring_loading_io.gif": "e5b006904226dc824fdb6b8027f7d930",
"assets/packages/status_alert/assets/fonts/SFNS.ttf": "9e14b4e72dec1db9a60d2636bbfe64f2",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "bb0adb34cf529d01cb94ba44932fb265",
"/": "bb0adb34cf529d01cb94ba44932fb265",
"main.dart.js": "f3bcddba4049ac04ab786b3fd5c75ba6",
"manifest.json": "2fd27f294fc3c696fa1c344f15b7858a"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
