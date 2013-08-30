---------------------------------------------------------------------------
-- FILE    : cryptographic_services.ads
-- SUBJECT : Specification of a package to abstract the crypto needed by Thumper.
-- AUTHOR  : (C) Copyright 2013 by Peter Chapin and John McCormick
--
-- Please send comments or bug reports to
--
--      Peter Chapin <PChapin@vtc.vsc.edu>
---------------------------------------------------------------------------
with Network;

package Cryptographic_Services
with
  Abstract_State => Key
is
   type Status_Type is (Success, Bad_Key, Insufficient_Space);

   procedure Initialize(Status : out Status_Type)
   with
     Global => (Output => Key),
     Depends => ((Key, Status) => null);

   -- Computes the signature of Data using a constant private key that is internal to this package, putting the result in
   -- Signature. The number of octets used are written to Octet_Count. Fails with Insufficient_Space if the Signature array
   -- is not large enough to hold the signature. Fails with Bad_Key if the key is invalid.
   --
   procedure Make_Signature
     (Data        : in  Network.Octet_Array;
      Signature   : out Network.Octet_Array;
      Octet_Count : out Natural;
      Status      : out Status_Type)
   with
     Global => (Input => Key),
     Depends => (Signature => (Data, Key), (Octet_Count, Status) => (Data, Signature));

end Cryptographic_Services;
