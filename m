From: GeunSik Lim <leemgs1@gmail.com>
Subject: [patch] cyclictest: bugfix getopt_long() for -C and -F.
Date: Wed, 08 Apr 2009 22:49:26 +0900
Message-ID: <1239198566.30137.25.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:60951 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbZDHNtg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Apr 2009 09:49:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so115328rvb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Apr 2009 06:49:35 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Author: Lim,GeunSik <leemgs1@gmail.com>
Date:   Wed Apr 8 22:21:59 2009 +0900

    [patch] cyclictest: bugfix getopt_long() for -C and -F.
   =20
    We can not use -C option without --context option for tracing conte=
xt switching.
    ex) ./cyclictest -t 10 -m -b 100 -C
    We can not use -E option without --event option for tracing events.
    ex) ./cyclictest -t 10 -m -b 100 -E
    Append -C and -E option on getopt_long() function to solve this pro=
blems.
   =20
    Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f878217..1660893 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -777,7 +777,7 @@ static void process_options (int argc, char *argv[]=
)
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c =3D getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:nNo:p:Pmqrst::=
vD:",
+		int c =3D getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:p:Pmqrst=
::vD:",
 			long_options, &option_index);
 		if (c =3D=3D -1)
 			break;

=20
=20
 =20
=20
-----------------------------------------------------------------------=
---- =20
GeunSik Lim, Embedded Linux Solution, OS Group, Software Lab, SAIT
e-Mail   : 1) geunsik.lim@samsung.com
           2) leemgs@gmail.com , leemgs1@gmail.com
MSN      : invain@hanmail.net=20
ICQ      : 46455794gTalker  : leemgs@gamil.com , leemgs1@gmail.com
HomePage:  http://intomail.dnip.net/invain/me/=20
=A2=C0 If you continue to keep a dream, you come to realize.  - Goethe =
=20
-----------------------------------------------------------------------=
----

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
