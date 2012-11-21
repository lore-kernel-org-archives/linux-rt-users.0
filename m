From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH] Changes the getcmdpath method to use only python calls to find the paths
Date: Wed, 21 Nov 2012 18:22:11 -0500
Message-ID: <1353540131-18978-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, dsommers@redhat.com,
	=?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47982 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801Ab2KVUuX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Nov 2012 15:50:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2511242iea.19
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Nov 2012 12:50:23 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In my previous patches, I introduced a getcmdpath method which intended
to replace the direct calls to binary from clear paths, using the which
binary to locate the place of the searched one. This behavior was in
fact not the finest as the method itself used the full path to the whic=
h
binary. In this patch, I corrected the getcmdpath command to use only
python calls (os.path.isfile and os.access) to identify in the PATH
environment variable the place where the binary is.

Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
---
 rteval/rteval.py |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rteval/rteval.py b/rteval/rteval.py
index beba49f..5843d78 100644
--- a/rteval/rteval.py
+++ b/rteval/rteval.py
@@ -68,10 +68,16 @@ from cputopology import CPUtopology
=20
 pathSave=3D{}
 def getcmdpath(which):
+    """
+    getcmdpath is a method which allows finding an executable in the P=
ATH
+    directories to call it from full path
+    """
     if not pathSave.has_key(which):
-        cmd =3D '/usr/bin/which %s' % which
-        c =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.=
PIPE)
-        pathSave[which] =3D c.stdout.read().strip()
+        for path in os.environ['PATH'].split(':'):
+            cmdfile =3D os.path.join(path, which)
+            if os.path.isfile(cmdfile) and os.access(cmdfile, os.X_OK)=
:
+                pathSave[which] =3D cmdfile
+                break
         if not pathSave[which]:
             raise RuntimeError, "Command '%s' is unknown on this syste=
m" % which
     return pathSave[which]
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
