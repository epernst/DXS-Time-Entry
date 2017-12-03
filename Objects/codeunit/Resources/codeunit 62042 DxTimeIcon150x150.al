codeunit 62042 DxTimeIcon150x150
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
            'iVBORw0KGgoAAAANSUhEUgAAAJYAAACWCAYAAAA8AXHiAAAAB3RJTUUH4QofCAoPN0WZTAAAAAlwSFlzAABOIAAATiABFn2Z3gAAAARnQU1BAACxjwv8YQUAAARLSURBVHja7' +
            'd0xdlNBEERRb4z9sSD2J1IHsqz/NTOvu/oFFYKqay7gYwd8PR6PL2NWBy9gMoMXMJnBC5jM4AV25u+/P4+KoXcRlrDaBi8grMzgBYSVGbyAsDKDFxBWZvACwsoMXkBYmcELCC' +
            'szeAFhZQYvIKzM4AWElRm8gLAygxcQVmbwAsLKDF5AWJnBCwgrM3gBYWUGLyCszOAFhJUZvICwMoMXEFZm8ALCygxeQFiZwQsIKzN4AWFlBi8grMzgBYSVGbyAsDKDFxBWZvA' +
            'CwsoMXkBYmcELCKt27vb96KHoo4V1ZrfjsKqPRQNK2mobrI7D0YCS9ikBq8qINKCkTcrBIgelAaXtsBxW13FpQGm3t4B1Ymwa0GlYlXqXKLxreBpQ2n1LYXV+BLp74k0xsD55' +
            'ELpv4h2RsK4eSHec2r01rHcOpjtdfRy610pcEah+Opzu8c7D0F2EZcpEWAbDJSojLFMnwiqSxE0vw6IL7xxBVMKKwJW8qbCeDJH4efSmL2HRRU+O0P1zKkRYhx590r8AwnpjC' +
            'FGtvdshFt0++ds2v8KiC9Kw7m4w/cdiwnoDwpUdVv0+CRHWIhS//frpe44c4V0YP+0iKmEtx/UJyPQI6yKSO6Fvo/ccO8JOWPRdFfYcPcQuXPRNFbYcPYSw9u05eoQduOhb6A' +
            'hLWMLqAou+g87TbzdMHcevr/bsN3okv92wb7eRY+0C5WY3YKUMdgrV9K3GDHca1PSdRoxHo5q4T/SQNKSqu5zYJnZMGk+1PU5vEjkqjcYtCvy3cgkjVtqgyg54gVUDr/z8qff' +
            'HwrozMv2nfvXndMbUAtbKx9sFq2KnKsELVAXWsU+l4AWEJawxqN59zGp9KgUvUBXVbw9ZsVOl4AWEJaxRqKrC6oILL1D18V49It2pAy68QGVUwhLWOFjVceEFKj9cdViVceEF' +
            'Kj/as8eju3TBhRcQlrBGouoAqyIuvED1B+sCqxouvED1x/r+aHQHYQlrPC68AP0QabCq4BJVIKwKuEQVGmGZSFyiCs8YWPTQ0yIsE4VLVBceh+7QCZeoLj4K3aULLlEJS1hVH' +
            'oPu1AGXqG4+At2tOi5R3Ryf7iespvG+orDo4U6NTnetiktUC8amO4+ARY8lrBq4hLVoZLp7NVyiWjgufQN9/xZY9DAVRqXvqLCBsDaNSt9SZQfH3PD1BX1ThT1Gj7kDVdctSv' +
            '6N1XXUXbC67bBji7Gj7kTlDkN/pHMC1fQdxg17ElXF+0/tMG7c07Cm3j9qXALV1PvHDEyiomER944ZmYY17e4RQ9OgKFzknfFD0/dNvRkvsHNo+i4CFn1bKVi7BqfvOY2Lvqk' +
            'srJWD03dMvxUvsGNwuv9JWPQNrWB9Ojzd2xuLw7ozPN3XG5vAujI83dMbm8F6Z3y6225YdL9oWK8egO7lbc1hPXsAuo+3hcD6/gh0h12w6B6jYZm6wQuYzOAFTGb+A8YtMHam' +
            'q9pXAAAAAElFTkSuQmCC');
    end;
}

