From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH 2/3] Adds getcmdpath method to use which to locate the used commands
Date: Tue, 23 Oct 2012 11:45:04 -0400
Message-ID: <1351007105-7852-3-git-send-email-raphael.beamonte@gmail.com>
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
	with ESMTP id S1757058Ab2JWPpp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 11:45:45 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5480558iea.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2012 08:45:44 -0700 (PDT)
In-Reply-To: <1351007105-7852-1-git-send-email-raphael.beamonte@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
---
 rteval/rteval.py |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/rteval/rteval.py b/rteval/rteval.py
index a432233..f54c1f4 100644
--- a/rteval/rteval.py
+++ b/rteval/rteval.py
@@ -63,6 +63,17 @@ import rtevalMailer
 from cputopology import CPUtopology
=20
=20
+pathSave=3D{}
+def getcmdpath(which):
+    if not pathSave.has_key(which):
+        cmd =3D '/usr/bin/which %s' % which
+        c =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.=
PIPE)
+        pathSave[which] =3D c.stdout.read().strip()
+        if not pathSave[which]:
+            raise RuntimeError, "Command '%s' is unknown on this syste=
m" % which
+    return pathSave[which]
+
+
 sigint_received =3D False
 def sigint_handler(signum, frame):
     global sigint_received
@@ -249,7 +260,7 @@ class RtEval(object):
         policies =3D {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'u=
nknown' }
         ret_kthreads =3D {}
         self.debug("getting kthread status")
-        cmd =3D '/bin/ps -eocommand,pid,policy,rtprio,comm'
+        cmd =3D '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('p=
s')
         self.debug("cmd: %s" % cmd)
         c =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.=
PIPE)
         for p in c.stdout:
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
