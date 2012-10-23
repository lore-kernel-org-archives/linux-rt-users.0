From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH 1/3] Rewrite of the get_kthreads method to make it cross-distribution
Date: Tue, 23 Oct 2012 11:45:03 -0400
Message-ID: <1351007105-7852-2-git-send-email-raphael.beamonte@gmail.com>
References: <1351007105-7852-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50253 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab2JWPpm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 11:45:42 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5480558iea.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2012 08:45:42 -0700 (PDT)
In-Reply-To: <1351007105-7852-1-git-send-email-raphael.beamonte@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
---
 rteval/rteval.py |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rteval/rteval.py b/rteval/rteval.py
index 5ecc20f..a432233 100644
--- a/rteval/rteval.py
+++ b/rteval/rteval.py
@@ -248,16 +248,15 @@ class RtEval(object):
     def get_kthreads(self):
         policies =3D {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'u=
nknown' }
         ret_kthreads =3D {}
-        if not os.path.exists('/etc/rc.d/init.d/rtctl'):
-            return ret_kthreads
         self.debug("getting kthread status")
-        cmd =3D '/sbin/service rtctl status'
+        cmd =3D '/bin/ps -eocommand,pid,policy,rtprio,comm'
         self.debug("cmd: %s" % cmd)
         c =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.=
PIPE)
         for p in c.stdout:
             v =3D p.strip().split()
+            kcmd =3D v.pop(0)
             try:
-                if int(v[0]) > 0:
+                if int(v[0]) > 0 and kcmd.startswith('[') and kcmd.end=
swith(']'):
                     ret_kthreads[v[0]] =3D {'policy' : policies[v[1]],=
=20
                                           'priority' : v[2], 'name' : =
v[3] }
             except ValueError:
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
