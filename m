From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH 3/3] Rewrite of the get_services method to make it cross-distribution
Date: Tue, 23 Oct 2012 11:45:05 -0400
Message-ID: <1351007105-7852-4-git-send-email-raphael.beamonte@gmail.com>
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
	with ESMTP id S933195Ab2JWPps (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 11:45:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5480558iea.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2012 08:45:47 -0700 (PDT)
In-Reply-To: <1351007105-7852-1-git-send-email-raphael.beamonte@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Changes the get_services method to call the new created
__get_services_sysvinit and __get_services_systemd methods
to be able to manage the two different init daemons.

Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
---
 rteval/rteval.py |   73 +++++++++++++++++++++++++++++++++++++++++++---=
--------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/rteval/rteval.py b/rteval/rteval.py
index f54c1f4..829a49b 100644
--- a/rteval/rteval.py
+++ b/rteval/rteval.py
@@ -48,6 +48,9 @@ import signal
 import rtevalclient
 import ethtool
 import xmlrpclib
+import platform
+import fnmatch
+import glob
 from datetime import datetime
 from distutils import sysconfig
=20
@@ -92,6 +95,7 @@ class RtEval(object):
         self.inifile =3D None
         self.cmd_options =3D {}
         self.start =3D datetime.now()
+        self.init =3D 'unknown'
=20
         default_config =3D {
             'rteval': {
@@ -239,22 +243,61 @@ class RtEval(object):
                     topology.getCPUsockets()))
         return topology.getXMLdata()
=20
-
-
-    def get_services(self):
-        rejects =3D ('capi', 'firstboot', 'functions', 'halt', 'iptabl=
es', 'ip6tables',=20
-                   'killall', 'lm_sensors', 'microcode_ctl', 'network'=
, 'ntpdate',=20
-                   'rtctl', 'udev-post')
-        service_list =3D filter(lambda x: x not in rejects, os.listdir=
('/etc/rc.d/init.d'))
+    def __get_services_sysvinit(self):
+        reject =3D ('functions', 'halt', 'killall', 'single', 'linuxco=
nf', 'kudzu',
+                  'skeleton', 'README', '*.dpkg-dist', '*.dpkg-old', '=
rc', 'rcS',
+                  'single', 'reboot', 'bootclean.sh')
+        for sdir in ('/etc/init.d', '/etc/rc.d/init.d'):
+            if os.path.isdir(sdir):
+                servicesdir =3D sdir
+                break
+        if not servicesdir:
+            raise RuntimeError, "No services dir (init.d) found on you=
r system"
+        self.debug("Services located in %s, going through each service=
 file to check status" % servicesdir)
         ret_services =3D {}
-        self.debug("getting services status")
-        for s in service_list:
-            cmd =3D ['/sbin/service', s, 'status']
-            c =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE)
-            status =3D c.stdout.read().strip().translate(self.transtab=
le, self.junk)
-            ret_services[s] =3D status
+        for service in glob.glob(os.path.join(servicesdir, '*')):
+            servicename =3D os.path.basename(service)
+            if not [1 for p in reject if fnmatch.fnmatch(servicename, =
p)] and os.access(service, os.X_OK):
+                cmd =3D '%s -qs "\(^\|\W\)status)" %s' % (getcmdpath('=
grep'), service)
+                c =3D subprocess.Popen(cmd, shell=3DTrue)
+                c.wait()
+                if c.returncode =3D=3D 0:
+                    cmd =3D ['env', '-i', 'LANG=3D"%s"' % os.environ['=
LANG'], 'PATH=3D"%s"' % os.environ['PATH'], 'TERM=3D"%s"' % os.environ[=
'TERM'], service, 'status']
+                    c =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PI=
PE, stderr=3Dsubprocess.PIPE)
+                    c.wait()
+                    if c.returncode =3D=3D 0 and (c.stdout.read() or c=
=2Estderr.read()):
+                        ret_services[servicename] =3D 'running'
+                    else:
+                        ret_services[servicename] =3D 'not running'
+                else:
+                    ret_services[servicename] =3D 'unknown'
         return ret_services
-           =20
+       =20
+    def __get_services_systemd(self):
+        ret_services =3D {}
+        cmd =3D '%s list-unit-files -t service --no-legend' % getcmdpa=
th('systemctl')
+        self.debug("cmd: %s" % cmd)
+        c =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.=
PIPE, stderr=3Dsubprocess.PIPE)
+        for p in c.stdout:
+            # p are lines like "servicename.service status"
+            v =3D p.strip().split()
+            ret_services[v[0].split('.')[0]] =3D v[1]
+        return ret_services
+
+    def get_services(self):
+        cmd =3D [getcmdpath('ps'), '-ocomm=3D',  '1']
+        c =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE)
+        self.init =3D c.stdout.read().strip()
+        if self.init =3D=3D 'systemd':
+            self.debug("Using systemd to get services status")
+            return self.__get_services_systemd()
+        elif self.init =3D=3D 'init':
+            self.init =3D 'sysvinit'
+            self.debug("Using sysvinit to get services status")
+            return self.__get_services_sysvinit()
+        else:
+            raise RuntimeError, "Unknown init system (%s)" % self.init
+        return {}
=20
     def get_kthreads(self):
         policies =3D {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'u=
nknown' }
@@ -434,7 +477,7 @@ class RtEval(object):
         self.xmlreport.taggedvalue('memory_size', "%.3f" % self.memsiz=
e[0], {"unit": self.memsize[1]})
         self.xmlreport.closeblock()
=20
-        self.xmlreport.openblock('services')
+        self.xmlreport.openblock('services', {'init': self.init})
         for s in self.services:
             self.xmlreport.taggedvalue("service", self.services[s], {"=
name": s})
         self.xmlreport.closeblock()
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
