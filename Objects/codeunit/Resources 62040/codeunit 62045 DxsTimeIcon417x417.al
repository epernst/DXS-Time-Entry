codeunit 62045 DxsTimeIcon417x417
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
        exit(
            'iVBORw0KGgoAAAANSUhEUgAAAaEAAAGhCAYAAADIqAvCAAAAB3RJTUUH4QofCAc3qulfnwAAAAlwSFlzAABOIAAATiABFn2Z3gAAAARnQU1BAACxjwv8YQUAABJmSURBVHja7dhBllzbbURRT8zz84A8v+/ut5Yli2RlHuBiN3abyHcDiFX8j7/++us/AKCQDw' +
            'DAXfkAANyVDwDAXfkAANyVDwDAXfkAANyVDwDAXfkAANyVDwDAXfkAANyVDwDAXfkA3PBf//2ffzFXnQ/uygfghvrIooSYKR+AG+ojixJipnwAbqiPLEqImfIBuKE+sighZsoH4Ib6yKKEmCkfgBvqI4sSYqZ8AG6ojyxKiJnyAbihPrIoIWbKB+CG+siihJgp' +
            'H4Ab6iOLEmKmfABuqI8sSoiZ8gG4oT6yKCFmygfghvrIooSYKR+AG+ojixJipnwAbqiPLEqImfIBuKE+sighZsoH4Ib6yKKEmCkfgBvqI4sSYqZ8AG6ojyxKiJnyAbihPrIoIWbKB+CG+siihJgpH4Ab6iOLEmKmfABuqI8sSoiZ8gG4oT6yKCFmygfghvrIoo' +
            'SYKR+AG+ojixJipnwAbqiPLEqImfIBuKE+sighZsoH4Ib6yKKEmCkfgBvqI4sSYqZ8AG6ojyxKiJnyAbihPrIoImbKB+CG+sCihJgpH4Ab6gOLEmKmfABuqA8sSoiZ8gG4oT6wKCFmygfghvrAooSYKR+AG+oDixJipnwAbqgPLEqImfIBuKE+sCghZsoH4Ib6' +
            'wKKEmCkfgBvqA4sSYqZ8AG6oDyxKiJnyAbihPrAoIWbKB+CG+sCihJgpH4Ab6gOLEmKmfABuqA8sSoiZ8gG4oT6wKCFmygfghvrAooSYKR+AG+oDixJipnwAbqgPLEqImfIBuKE+sCghZsoH4Ib6wKKEmCkfgBvqA4sSYqZ8AG6oDyxKiJnyAbihPrAoIWbKB+' +
            'CG+sCihJgpH4Ab6gOLEmKmfABuqA8sSoiZ8gG4oT6wKCFmygfghvrAooSYKR+AG+oDixJipnwAbqgPLEqImfIBuKE+sCghZsoH4Ib6wKKEmCkfgBvqA4sSYqZ8AG6oDyxKiJnyAbihPrAoIWbKB+CG+sCihJgpH4Ab6gOLEmKmfABuqA8sSoiZ8gG4oT6wKCFm' +
            'ygfghvrAooSYKR+AG+oDixJipnwAbqgPLEqImfIBuKE+sCghZsoH4Ib6wKKEmCkfgBvqA4sSYqZ8AG6oDyxKiJnyAbihPrAoIWbKB+CG+sCihJgpH4Ab6gOLEmKmfABuqA8sSoiZ8gG4oT6wKCFmygfghvrAooSYKR+AG+oDixJipnwAbqgPLEqImfIBuKE+sC' +
            'ghZsoH4Ib6wKKEmCkfwALcUB9YlNBV09951MeZ+pH43FszR50RvrNv9Wz/aOyHmvrB+Nxbo4T4/I7Vc/6jFR9t6sfjc2+NEuJze1XP/XcrP+C0j8hn3xolxM/uUv0b/m71h5z4Qfn8e6OErnn5rZ/5qFM/MJ9/b+zNi66897MfeNqHvq4+sNiV6a6+94mPPe2j' +
            'X1QfWOzHRN77WAlNfIAr6vfGTkxRv/O0Nz//CFMe4nX1G2MP5H/mm3uMgY/yovpdkX2Zn/nmHmb4A72ifkvkXc5nvrtHWvRYm9Vvh3zL9sx391hLH26b+r2QaXme+e4e7oFH3KB+I+RYhme+u0d87EGnqt8F2ZXbmW/vMR992Gnqt0BeZXXm23vYA488Qf39kV' +
            'H5nPn2HvnYg1ty5FImJ72/Bx+gXkbvjxzydAnVH3eTekll4K46I7J38/2FYLB6eWXgljoj8tZTQowKhwzcUmdExnpPllD9UV9UL7scvKnOiFz1lBArQiMHb6ozIkszKCFWBUgO3lFnRH5meKqE6o95XX04ZGGXOiMyM4MS4olgycI+dUbkZA4lxDMBk4U9FA9F' +
            'FgTrOIcGWaDKghLia8Grfxvenzl5UEJ8PYD178Gb0+ZBCZEGsp6f7xyd+jcwKw9ZCdUfj3nhrGfmc0ennpt5mVBCjAtpPSc/e3DqWZmXCSVETiZ2s9f8aiZGllD90ZhBLvaxz/w7mVBCrCMXO9hh/lUulBAAX7eqhOqPBcDPUkIApJQQAJkVJVR/JAA+QwkBkF' +
            'JCwI8elHoGdlFCPEdufHf2GF1C9cdhJ/nxzdlFCfEcGfKt2UMJ8Rw58p3ZY2QJ1R+F3WTK92UXJcRz5Mp3ZQ8lxHNkyzdlj1ElVH8M3iFjviV7KCGeI2e+I3soIZ4jb74fe4woofoj8B65893YQQnxJNnzzdhDCfEk+fvMEahn5T1KiCfJoO/EDmkJ1T+ed8mj' +
            '78MeSognyaTvwg5KiCf5L2LfhB2SEqp/NDc4uj+z6PXsvE8J8SSH13dgByXEk37iz/z6N/j9XPDVEqp/LLdcPcRXfzd7KSGe9BPHeFtuL/5m9lNCPOvSUf6p37rl9/KOr5RQ/SO56cphvvI7eZcS4kk/eZwnZvn138cdSohnvXqoX/1d3KSEeNYnjnWd6Rd/E3' +
            'yshOofBi8d7U/9FrtKTQnxrE8e7m9m/IXfAD+Zb+FmhU+X0Kdzvn1++FTWBZs1th7yb8xtV5lCCfGsjcd848zwzcwLN2t866D/VO63zQtF7gWbVb552P9kBzbMCBP2VLhZ5dsl9Kt7MH0+mLanws06Uw99MZc9ZaIfKaH6R8BPBPxbx37iTLBhT4WbdaqD/8/2' +
            'Yto8MIES4mnl4f/7fkyYASZSQjytLqEJ6jeAn9hT4WatugRq9feHn9hR4WatugQUEPz5jgo4a9VFoITgz/dUuFmtLgMlBH+2o8LNanUZKCD4sx0VcNarS0EJwe/vqHCzXl0KCgh+f0cFnPXqYlBC8Ps7KuA8oS4HJQS/t6PCzRPqclBA8Hs7KuA8oy4JJQS/vp' +
            '8CzjPqklBA8Os7KuQ8oy4KJQS/vqMCzlPqslBC8Gv7KeA8pS4LBQS/tp9CznPq0lBC8O/vo8DznLo0FBDX/UrGLQFPqUtDCXHV72bcQvCMujAUEdf8RL4tBuvVJaGIuOSns21BWK0uB2XEBZ/MtCVhpboMFBGv+1aeLQvr1CUwRf0OvKfIsYVhjfroT1S/CfvV' +
            'GbY8rFAvynT1+7BLndcRJWSB2LYs09VvxWx1PkeXkEVi09JMV78bc9RZXFlClok6dy+o3xD780QJWap76py9pn5P7M0zJWSx3lfn6mX122Jfniohy/WWOkNX1O+MXXmyhCzabnVeLqrfHDvydAlZth3qbFxXvz9240QJWbqZ6ixgL6apc6CELN4J9btjHyap33' +
            '2KfIBaHcQr6nfGLkxQv/FE+QCT1AF9Uf2m2IFa/abT5QNMVod3u/r9kH3Zny8fYIs61JvUb4XMy/0e+QAb1WGfrH4b5F3ed8kH2K5eginqd0DOZX2nfICX1MthKZFxGd8mH+BV9dJYTGRbvjfIB7igXiYLilzL9VT5ABfVi2ZJkWWZniIf4Lp6AS0r13Isy7Pk' +
            'AzB/kevvwg51TuV4p3wAZi90/R0+/T3ruV5UZ9b77pIPwMylrn/zN3/71t9Vv82Et9v4Xfjf8gGYt9hb5pz0ezd+n5d+Z72X/L58AOYs+aQD+dox/uS7bfhu9b/PXPkAOGw1b7VHvWP8vHwAHLkJvM1c9S7xWfkAOHoTeI9Z6p3he/IBcPgm8BYz1HvC9+UD4O' +
            'hN4C3mqPeF78oHwOGbwlvMUO8L35UPgKM3hfeYo94bvicfAAdvCm8yS70/fEc+AA7eFN5jnnqH+Lx8ABy8SbzJLPUe8Xn5ADh2k3iXeep94rPyAXDoJvE2M9V7hRLCoVt97OrftV29VyghHLrVB6/+TS+o9wslhCO39tjVv+kV9Z6hhHDkVh66+je9pN41lBAO' +
            '3KojV/+e19T7hhLCgVt16Orf8qJ671BCOG5rjlz9W15V7x9K6Lz6CLzMO81X7x9K6LT6AFzgnear9xAldFK9+Fd4qx3qfUQJnVMv/RXeaod6H1FCp9QLf4m32qPeS5TQCfWiX+S99qj3EyX0tHrBr/Jmu9R7ihJ6Vr3cV3mzXeo9RQk9qV7sy7zZPvW+ooSeUi' +
            '80v3fU6pmvq/cWJfSMeplRQhvVe4sSekK9yCihzer9RQmtVi8wv3/M6nlRRJvkA+CIbeD99qr3GSW0Tr20KKGX1PuMElqlXliU0IvqvUYJrVAvKn9+xOo5UUTb5APggG3hDXer9xslNFq9oCihC+o9RwmNVC8mSuiSet9RQqPUC8nPHa96PhTRRvkA19XLyM8d' +
            'r3o2lNBG+QCX1YuIErqs3n+UkAJCCR1X3wGUkBLiR45WPRdKaKt8gIvqxePnD1c9E4poq3yAa+qFQwmhiCbJB7ikXjQ+c7DqeVBCm+UDXFIvGkoIRTRNPsAV9YLxuYNVz4Ii2iwf4IJ6sVBCKKKp8gEuqJeKzx2qeg6U0Hb5AK+rFwolhCKaLB/gZfUi8flDVc' +
            '+AItouH+BV9QKhhFBCG+QDvKpeIEARbZAP8KJ6cQBFtEU+wGvqhQEU0Sb5AC+pFwVQQtvkA7ykXhRAEW2TD/CKekEARbRRPsAL6sUAlNBW+QAvqBcDUERb5QNsVy8EoIg2ywfYrF4EQBFtlw+wVb0AgBJ6QT7AVvUCAL36Dr0gH2CjOvj0ZIF/zAJKSAHx9cNT' +
            'z0Gvvknb5QNsUweenkzw/2UCJaSA+OqxqeeiV9+nrfIBtqgDzgwywu/mAyWkgPjoganno1ffqo3yATaog01PVvjprKCEHBU+clTqeenVd2uTfIDJ6iAzg9zw6cxclg8wWR1kerLDt7NzTT7AVHWA6ckQdYYuyAeYqA4uPVliUo5elg8wTR1aZpAnpmXpVfkA09' +
            'SBpSdTTM/US/IBJqmDSk+22Jat7fIBpqgDygzyxbZsbZcPMEUdUHoyxvaMbZQPMEEdTHqyxmtZ2yIfoFYHkp688WreNsgHUEDU5I7XMzdZPoAS4uIxqH83vfr+TZEP4Ahw9QjUv59encEJ8gEsP1cPQP376dUZnCAfwPJzefnr70CvzmAtH8DSc33p6+9Br86g' +
            'ErLsHF72+pvQqzOohCw6x5e9/i706gwqIUvO8SWvvw+9OoNKyHJzfLnr70SvzqASstQcXuz6O9GrM6iELDXHl7r+XvTqDCohy8zxZa6/G706g0rIEnN4ietvR6/OoBKywBxf4vr70aszqIQsL8eXt/6O9OoMKiFLy/Glrb8n8qyELCuHl7b+nvTqDCohy8rxZa' +
            '2/K706g0rIknJ0SWWclzOeD2A5sZxyzt2c5wNYTiynrHM36/kAFhNLKe/czXw+gMXEMso6dzOfD2BBsZByzt285wNYUCyknHM36/kAFhRLKefczXo+gCXFUso3d7OeD2BRsZjyzd2M5wNYVCynfHM34/kAlhXLKdfczXg+gIXFgsr1dXV2lJClxZLK9FF1Zmr5' +
            'ALU6gFhSmb6pzskU+QAT1GHEosrzLXVGJskHmKQOJpZVlt9XZ2OafIBp6oBiWWX5TXUepsoHmKgOKxZWjt9SZ2GyfIDJ6uBeVr/9K+p3RJaVkCVep37z19TveVX97lvkA2xQh/mS+q1fVb/rNfV7b5IPsEkd7NfV7/uy+m0vqd96m3yAbeqAv6x+29fV7/u6+n' +
            '23ygfYqA77i+o3vaJ+51fV77pZPsBmdfBfUb/jJfVbv6Z+zxfkA2xXL8EL6je8pn7vV9Tv+Ip8gBfUy7BZ/XZX1e++Xf1+L8kHeEm9GNvU73VZ/fZb1e/2onyA19RLskX9TsiqzM6QD/Cielk2qN8IWZXXGfIBXlYvzlT1uyCnsjpHPsDr6iWapn4PZFRWZ8kH' +
            'uKJeqCnqd0A+5XSWfIBL6sWq1d8f+ZTRefIBrqmXzHIjmzI6ST7AVfXCWW6u51I+Z8gHuKxePkvO5VzK5gz5ANfVS2jJuZhL2ZwjH4B3l77+psijXM6XD8Cbi19/S+RRLnfIB+DNxa+/I/IokzvkA/De8tffDjmUxz3yAXjrANTfDDmUx13yAXjrANTfCzmUxV' +
            '3yAXjnCNTfCBmUw33yAXjjCNTfhtv5k8O98gHYfwjqb8Lt/MngbvkA7D8G9bfgbvbkb798AHYfg/obcDN38veOfAD2HoT6t3Mzd7L3lnwA9h6F+jdzL3Ny9558AHYehfq3MoMC4k/lA7DvMNS/jzmUD38qH4Bdx6H+XcyjgPgT+QDsOg71b2ImBcTvygdgz4Go' +
            'fwdzKR9+Vz4AO45EPT/zKSB+Rz4AO45EPTs7yBi/Kh+A+Yeinpc9FBC/Kh+A2ceinpN9FBC/Ih+Auceino+9lA//rnwAeo4E38yVbPF3+QDM4Ejw6UzJFv+XfADmcCT4VKbkin8mHwB4mwLiX8kHAOCufAAA7soHAOCufAAA7soHAOCufAAA7soHAOCufAAA7v' +
            'ofN6kZKDi1kmwAAAAASUVORK5CYII=');
    end;
}

