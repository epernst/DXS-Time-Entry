codeunit 62014 DxTimeIcon100x94
{

    trigger OnRun();
    begin
    end;

    procedure GetIcon(var TempBlob : Record TempBlob);
    begin
        TempBlob.FromBase64String(IconSource);
    end;

    local procedure IconSource() : Text;
    begin
        EXIT(
            'iVBORw0KGgoAAAANSUhEUgAAADIAAAAvCAYAAAHWcKliAAAAB3RJTUUH2gQdCAw0q5BWagAAAAlwSFlzAABOIAAATiABFn2Z3gAAAARnQU1BAACxjwv8YQUAAAZrSURBVHja' +
            '7VoLiFZFFJ7/d0V7kJtasS6tj8yy1Kwk09YeriGSaZu6sUZlGrRqkVFoRo8VzIReSIEuq7Qp2DtNI8rWEnpHD+1lJrqbtNEDy+jF1op9384MzZ1/5t65d1cz6MBh5s45cx4z' +
            'c2fOnHuFMGDpC2M2ms95EYWJ5kNO9ThgMYnbJr6ey9sNBT2N3muAV2mmvCkWjVc71aBhHfA1/Vxk0C6L6HJZqPWM09YZFs5y+mX79ACwV4E/loUHzN4u/e1MwMdFDIC+Wguj' +
            'N+ehfMPiWQksAd4DfMuirc05JOrRNYenCM/7I+Yp5l2+MQS0eWkg3GUT8dwE3BaZIUfHmSguBRYD98GsSpNe5FB2svhn3rc6h9qCHka9m00sUma0kRHqf0PZ1WUyeFpR9OQw' +
            'foVKmcG0x3jeAJxkayiztJbpZeIa0rwivm+0NRn1j4z6bvJGhhUSv0dxnHr8GDiMFXNhmjM+xGAWmlnRnnQN6ydGnaP2tvFcFekACaeZpsGErsDRlrmPFcyYa1TsNueb6Oh0' +
            'LxU7SFthyZlJ/fNJDJ0BoUp6e9q7h3TW6/wWFPc76FuAc5KEqP1rGrCLRXoWwznVu6RtUNtRC6p9hFxGfP9/DXCkOzu+icroAObIqke/L1CcEtCtxbfPl6JoEPI4qQVuB3IV' +
            'DYSiaaBXoH4G8APgkcAXgbuAN4O+0ZbnXcLq1atykI72DNO3UFDikpV4YjmAu03/GHpfKNvjVQLhS1EsiBHQCwJ+VLx/Cfc+T9gGvuFJnnyOYrDRtBOdBjn4lqOoMZq46k6y' +
            'PYkFCOkGHBTANzuOHrp3rTMei3UFFl8U0r8ohElYMVRaOKw2yP+IEkxsl44KssGUqSd+ExrHCrlHPYhVszKj4AtQ1Am5cX4DLDWVjFUlX8B6MNej3AtcBYULEgRz5S0R0ZeX' +
            '0EdXcsqttgQjNwMrrLbtDsE21MDIOs7J6oCRYOh4nfHMQC9kSNtHgUquCGAuh0WrhHzbad1klHcH9Ouvhyvx6FVQC+GLWEEfBsj7AvuNMY/TBiEPqSMcjDdCwSNmA/gnCHki' +
            'uoB7XTX6tLZ74uKAgFoU1wJ5ZnDCRwp5/NKbVtAfQp03DsaoKxRtA2iXu+Q5N0gw10LQK0LevJoN0vHAWcB5VpdGnwKvJ8ob11z9AFwGXOygjYOizS5Zzr0LCr726Ga8P91D' +
            'a/QZXKBEve2lwg99Y7xvcrXnLaYTRfSls4HD1COG3g8yliR5EhcA7MCY36luy/Nj+BZC0VFxSt7x9YTwU436fSg+9bD+HOsJOo9CUenoWDAP4B3q4ONSLla3YK8n7LxeBdbf' +
            'qab6mDhqmFGvAN/FIi04L4mFPGuTeILirkCDfPdKHwTdN0PhkAQrhwL+d+Rwg850pHdK/qBMRihEjne8sEyYjhdyc30K+LKZA/03QSXhbgWeBWyBXROcjqgjhjHICcCzgdeo' +
            'ds3CzCSDn3eByyFo70EymGH/DOA5wIGiMB1EGAo+RoEP6wYzdFyPYnIG3X8ImdPMKeWhsFvII1gbnBaagUP0yaivcVMyOkFgzDxSGXQHkLHy7zH873FEhbwLTc/oBKEfsF4/' +
            '6Jd9UUZhNtwuZCaQy5SH3WeqnbeLZerrC53mN5XELEoAVGMSeB9ov/ow4L++kxwh7ASO8r1DB0Efk5PDOSM3Aa8UcpfaAezILsXl8iXwGI8TnCkmKn/poPHNwOeV7SN4G4uN' +
            'tdSXgblCrunTgT09xm8Czk6TpVM5Ay4xflA81sPG6wczh/wi+UzcUZApaFS3auYVyj3OaahkOK36PI1iqkXnjsdd508ht9l54H8ii02pT3a1PPjldVKCE4T5qs8AFJc46Nzx' +
            'GBEwvcPza41KFKeGVDMCJTegYGYgNCNK4NLhN/CqFH0+BJ5v35467Ihaz8xGnJthsBgNDE7pPIFn0Vw409ApjsAJjuSjQu42aeEnIfPUPPiybrnMnIxPivni0jWchZeE+pUg' +
            'AzSad1/I44cNZsNKMsjigToF8l5N5QiU8k8GhhIDMijlF5sZrg9ZSvZzwp19CIE6yK1xEZLOEc4KY6dqEZ8J0rBFyETa/gS5jO2Y3i0OkMlIYTFkxqaRg3ctNUs8mLhc7BeX' +
            'SaA5UJaY7bAGiY6XO8jMODJbvzBUXtYDkYEfZ2qEkLvZhVkvYJDFyxKDVjrGsGNmmm1Xw99G2iw3SE26kgAAAABJRU5ErkJggg==');
    end;
}

