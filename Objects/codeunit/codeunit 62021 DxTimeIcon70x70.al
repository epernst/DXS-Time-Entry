codeunit 62021 DxTimeIcon70x70
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
            'iVBORw0KGgoAAAANSUhEUgAAAEYAAABGCAYAAABxLuKEAAAAB3RJTUUH4QofCBQsQWPX4QAAAAlwSFlzAABOIAAATiABFn2Z3gAAAARnQU1BAACxjwv8YQUAAAGPSURBVHja' +
            '7dhRbgMhEAPQXKz364F6v61UKVKkKl1g7LGh/uAvYjxvCbD7uK7rkfF7yAM8x+fXxzUyjoIZbTowgQlMYAITmMAEJjCBCUxgAhOYwBwPgw7iBjMy31QTO8PMzllqwh2mMies' +
            'CRcY1JyUBrphGPPSGngtyIBh5GyF2WUEZhAnKDvDdOWTwqzclRSrRrJaRmsqVrMcZvSarsomLf6uefVJ+QOjKPwXDvPWvCUM+x0rMKAhLe4KI30lcFsxt99j2KHQX99YWVqD' +
            'raCoMrQErICo6reHHAl+99uOhyF9kiswXSsTNhGqIQcUyxWj2twtYV6bUp58cBjkBnwMDPJk6r6r/DsY+XGNbAQ9ZDDqxtk4x6JUcY6HWcU5HqUFhh3eCccKxgnHCmU7mO6w' +
            'DjjyzdblYVjBONeWwTj+heV7jPoktD2VVJdK2j0GEXK2HgpmtuZ0yErQlVqqmq1BKzArNSu1SkFnwlbrdNdrCYtC6awFC/wuNHL+OxxkDXpoBkxHHWpoFkpHDVrw3cc3tuMt' +
            'Mes21FcAAAAASUVORK5CYII=');
    end;
}

