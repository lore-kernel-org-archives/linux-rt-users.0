Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB0DC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Mar 2022 23:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiCDXYM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCDXYM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Mar 2022 18:24:12 -0500
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 15:23:21 PST
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF24DEC5
        for <linux-rt-users@vger.kernel.org>; Fri,  4 Mar 2022 15:23:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2BFFC6081109;
        Sat,  5 Mar 2022 00:18:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xwzdJ0nZLLDS; Sat,  5 Mar 2022 00:18:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1B46F6081108;
        Sat,  5 Mar 2022 00:18:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jA73h0jDo6RL; Sat,  5 Mar 2022 00:18:04 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5D3246081100;
        Sat,  5 Mar 2022 00:18:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] rt-tests: Support building with meson
Date:   Sat,  5 Mar 2022 00:17:51 +0100
Message-Id: <20220304231751.22856-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

While rt-test's Makefile is not super complicated I still think
it can benefit from meson.
meson gracefully handles dependencies and Python installations.

To build and install using meson, run:
	meson builddir
	ninja -C builddir
	DESTDIR=3D/your/dest ninja -C builddir install

Android support is completely untested.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 README.markdown |   6 +++
 meson.build     | 135 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 meson.build

diff --git a/README.markdown b/README.markdown
index 3ab6ddf53c7e..8fbab9e75de0 100644
--- a/README.markdown
+++ b/README.markdown
@@ -9,6 +9,12 @@ This repository contains some programs that test various=
 rt-linux features.
     sudo apt-get install build-essential libnuma-dev
     make
=20
+### Compile and install with meson
+
+    meson builddir
+    ninja -C builddir
+    DESTDIR=3D/your/dest ninja -C builddir install
+
 ### Run tests
=20
 To run one test thread per CPU or per CPU core, each thread on a separat=
e
diff --git a/meson.build b/meson.build
new file mode 100644
index 000000000000..d7220090a423
--- /dev/null
+++ b/meson.build
@@ -0,0 +1,135 @@
+project('rt-tests', 'c', version: '2.3')
+
+os_args =3D []
+want_andoid =3D false
+
+if target_machine.system() =3D=3D 'android'
+	os_args +=3D ['-DPTHREAD_BIONIC']
+	want_andoid =3D true
+endif
+
+add_global_arguments([
+	'-D_GNU_SOURCE',
+	'-Wno-nonnull',
+	'-DVERSION=3D@0@'.format(meson.project_version()),
+	os_args,
+        ],
+        language: 'c',
+)
+
+cc =3D meson.get_compiler('c')
+
+libdl_dep =3D cc.find_library('dl')
+librt_dep =3D cc.find_library('rt')
+
+thread_dep =3D dependency('threads')
+libnuma_dep =3D dependency('numa')
+
+base_inc =3D include_directories('src/include')
+
+pymod =3D import('python')
+pyinst =3D pymod.find_installation(required: false)
+
+rttest_lib =3D static_library(
+	'rtest',
+	[
+		'src/lib/rt-error.c',
+		'src/lib/rt-get_cpu.c',
+		'src/lib/rt-sched.c',
+		'src/lib/rt-utils.c',
+	],
+	include_directories: base_inc,
+)
+
+rttestnuma_lib =3D static_library(
+	'rtestnuma',
+	[
+		'src/lib/rt-numa.c',
+	],
+	include_directories: base_inc,
+)
+
+c_srcs =3D [
+	'src/cyclictest/cyclictest.c',
+	'src/hackbench/hackbench.c',
+]
+
+c_srcs_non_adroid =3D [
+	'src/oslat/oslat.c',
+	'src/pi_tests/pi_stress.c',
+	'src/pi_tests/pip_stress.c',
+	'src/pmqtest/pmqtest.c',
+	'src/ptsematest/ptsematest.c',
+	'src/queuelat/queuelat.c',
+	'src/rt-migrate-test/rt-migrate-test.c',
+	'src/sched_deadline/cyclicdeadline.c',
+	'src/sched_deadline/deadline_test.c',
+	'src/signaltest/signaltest.c',
+	'src/sigwaittest/sigwaittest.c',
+	'src/ssdd/ssdd.c',
+	'src/svsematest/svsematest.c',
+]
+
+if want_andoid =3D=3D false
+	c_srcs +=3D c_srcs_non_adroid
+endif
+
+py_srcs =3D [
+	'src/cyclictest/get_cyclictest_snapshot.py',
+	'src/hwlatdetect/hwlatdetect.py',
+]
+
+sh_srcs =3D [
+	'src/queuelat/determine_maximum_mpps.sh',
+]
+
+extra_link =3D {
+	'cyclictest': [rttestnuma_lib],
+	'oslat': [rttestnuma_lib],
+	'signaltest': [rttestnuma_lib],
+}
+
+extra_dep =3D {
+	'cyclictest': [libnuma_dep],
+	'oslat': [libnuma_dep],
+	'ptsematest': [libdl_dep],
+	'signaltest': [libnuma_dep],
+	'sigwaittest': [libnuma_dep],
+	'svsematest': [libnuma_dep],
+}
+
+foreach src: c_srcs
+	exe =3D src.split('/')[-1].split('.c')[0]
+	executable(
+		exe,
+		src,
+		include_directories: base_inc,
+		dependencies: [
+			libdl_dep,
+			librt_dep,
+			thread_dep,
+			extra_dep.get(exe, []),
+		],
+		link_with: [
+			rttest_lib,
+			extra_link.get(exe, []),
+		],
+		install: true,
+	)
+	install_man(src.split('.c')[0] + '.8')
+endforeach
+
+if pyinst.found()
+	pyinst.install_sources(py_srcs)
+	foreach src: py_srcs
+		install_man(src.split('.py')[0] + '.8')
+	endforeach
+endif
+
+install_data(sh_srcs,
+	install_dir: get_option('bindir'),
+	install_mode: 'rwxr-xr-x',
+)
+foreach src: sh_srcs
+	install_man(src.split('.sh')[0] + '.8')
+endforeach
--=20
2.26.2

