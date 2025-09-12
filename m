Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF3E555
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Sep 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708513; cv=none; b=C1SqM91effcduABzjCWnUsnp38IQhZt2R5nxKI9jtLbSoFXAUYWzbH34gBngGAqTZpqZdhErajdUGaqeSxWJZMPtE6XUen2pWGDEMLJFb2Fpo+annu0YskPUSeZl5tdwq8wPtsakqbXFzrXJJ/AQsUuXOuvLnwlRNIUv7Ag2Hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708513; c=relaxed/simple;
	bh=I4qKwXYdy83u8mbXOtKeh6+ajXp6KJxWwQyQZgcvhzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3C0Ka8B8ZgvxUWr98DUAsKdKEbV6GlAOX1yJf1BNr3pGQk8j2jihgtu8ptwesrvdPP2RLKcLNpZjpCd701/isSK5xkp9PCqgScRZJGZOQj9ZiWQqbjVLGXdUHUSpCiiYgODQQKcF3BY7/7Q+GnM4PKdVQUc0WqyrrvRP/prxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4CnJfBA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4CnJfBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757708510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vY/AYoWAJCe2Ns9wrG84UOj857u6rThG2gjeY1QQIyc=;
	b=b4CnJfBAzICD/GkBq5dbafk36iLQQ/INu2yxfb7yOAPQC3k2XU3cwjM/M2COjEITgY3iAI
	RbmiYis8PupjEzWnI4K32PqzytaFFP5DYiEKz9qngApHwCAC76l5DPGnai+nwS1oN4Hf7q
	Sgbq8a1T0Mw5Bt5VnKrPHQWgLprOeBE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-gd2Nj90yOM6iNl2sLh0bNw-1; Fri, 12 Sep 2025 16:21:48 -0400
X-MC-Unique: gd2Nj90yOM6iNl2sLh0bNw-1
X-Mimecast-MFC-AGG-ID: gd2Nj90yOM6iNl2sLh0bNw_1757708508
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5eb7b2c05so54855211cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Sep 2025 13:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757708508; x=1758313308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vY/AYoWAJCe2Ns9wrG84UOj857u6rThG2gjeY1QQIyc=;
        b=m4wIUrwyb4K/0c7znxmiQbsAB0ot1ljMMtkdR52MnqeiXiDziCG93h9Gyij9L/eGsJ
         ZQBmLSXgOHr5auizb45FKShogkbyHVLfDVvW40Z3PoFWvLg6nrhWb7hutRt6Yy4AhicZ
         1eYb9sM0dYvnO2i0CgSYDJ5yHVZN3IEvEzYN5h/jLwRXro7OmhUd8C447qIaF8oWS//k
         EMyd4mF78WAip82C+rc11PmmfjH8ofoL2qhLV3e7Qe1Bjpe5M6DBX8fdCgW0oiOw4Rgs
         UboY6xxgmeAUydw9oGWJpSmXPX6aebIGDCb74OJJIBe6a4uWICAlFSpuo8dsNN2o8Ikh
         ZzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcnaJmo4ZF4Sjm3jvF/1tBupFV7NR498dUUH0VOksYVqjranuSsjVgwoOGYkm2SvwoKEMtQujcW/libqvPPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgtcHizQLd7mTCMC66Q7VBrlOkrfjGe+vax5nvXpeMKu8AKQv
	O2WaBK1XTXorhypEoM4JBGutWJq0rjidE/FFJdUs0RM4Bn6aCrEfpO/3VEMk3Inee27gckv5P5a
	t9vTQHzSDfx/sfclbCf7pFWTfpXm0a9vEO63uqUYUP0NK3wyxQAUd02HjdMXJ4xBwJDMp
X-Gm-Gg: ASbGncsOVJzG04R+dW0cUwrPCb9nhpnobaJiahmxvpuSepZv/DxaeZh+sPXc/3C1xf7
	BNC4exlAiQluWU4gSCIQUJd9aYGV5G1N8l3NCMreSo6XUC8MW9k/2KzoZL4Hx1XXYsR8xkM/Qrr
	C9zW1s7jcioNTP8OIYTeYxNhb3Gx1Nl/5FdTn1GJIy34scdgSe2exfby85CW5faAv0GIun8DyMw
	pDrHQwR+3hC4LOA9AqIElGx0vNwNgnaiA0q/d+bsEEwWF9ocBPi2jpmzOmbQ8bSvuiYcLCOwvl0
	Fpd/z8Yhnbgy+NSyVtWJINURbtc2E0evSWE6qg==
X-Received: by 2002:a05:6214:e4b:b0:70d:daae:c5ff with SMTP id 6a1803df08f44-767c1b999e5mr62809156d6.39.1757708507598;
        Fri, 12 Sep 2025 13:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIsbNtW+W77XKs5CAvY1Jrwj+gupq15duAGGSBxtmGspdlqTenF6zUVpdRdtRSSgi2pf9htA==
X-Received: by 2002:a05:6214:e4b:b0:70d:daae:c5ff with SMTP id 6a1803df08f44-767c1b999e5mr62808756d6.39.1757708507063;
        Fri, 12 Sep 2025 13:21:47 -0700 (PDT)
Received: from thinkpad2024 ([71.217.40.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b450b4a2sm32882386d6.6.2025.09.12.13.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 13:21:46 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] Remove "Save kthread tunings" and obsolete rtctl elements.
Date: Fri, 12 Sep 2025 16:21:33 -0400
Message-ID: <20250912202134.26195-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tuna offered a way to export kthread tunable settings for a program called
rtctl that is no longer packaged in modern Linux distros. Removing this
functionality involved the removal of the `tuna save` command, a (right) menu
click option for the process list in the first tab of the Tuna gui, and the
removal of the 'Save Snapshot' button from the second tab of the Tuna gui. The
remaining changes involve translations with the removed elements.

Removing functionality that is not tested or used simplifies the code base and
makes Tuna more maintainable. `tuna save` especially caused confusion with
`tuna apply` as apply is intended for Tuna style configuration files and
shares nothing in common with `tuna save`.

I deleted instead of reusing `tuna save` to save Tuna style configuration
files to match `tuna apply` as it is an open question with my previous email
if the tuna profile functionality is used.

References to rtctl were not removed from testuna. That file uses an older
version of Tuna's commands and will not function with modern Tuna. The rtctl
references help to understand what the file was intending to do and
should be part of a separate cleanup or delete the file.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 docs/tuna.8            | 21 ----------
 po/ja.po               |  9 -----
 po/pt_BR.po            |  9 -----
 po/zh_CN.po            | 10 -----
 tuna-cmd.py            | 23 -----------
 tuna/config.py         | 50 -----------------------
 tuna/gui/commonview.py |  8 ----
 tuna/gui/procview.py   | 66 ------------------------------
 tuna/tuna.py           | 92 ------------------------------------------
 tuna/tuna_gui.glade    | 55 -------------------------
 tuna/tuna_gui.py       |  2 -
 11 files changed, 345 deletions(-)

diff --git a/docs/tuna.8 b/docs/tuna.8
index 6e30537..3adb598 100644
--- a/docs/tuna.8
+++ b/docs/tuna.8
@@ -148,27 +148,6 @@ optional arguments:
   -b, --background      Run command as background task
 
 .TP
-\fBtuna save\fR
-usage: tuna-cmd.py save [-h] [-c CPU-LIST | -S CPU-SOCKET-LIST | -N]
-                        [-t THREAD-LIST]
-                        FILENAME
-
-Save kthreads sched tunables to FILENAME
-
-positional arguments:
-  FILENAME              Save kthreads sched tunables to this file
-
-optional arguments:
-  -h, --help            show this help message and exit
-  -c CPU-LIST, --cpus CPU-LIST
-                        CPU-LIST affected by commands
-  -S CPU-SOCKET-LIST, --sockets CPU-SOCKET-LIST
-                        CPU-SOCKET-LIST affected by commands
-  -N, --nohz_full       CPUs in nohz_full kernel command line will be affected
-                        by operations
-  -t THREAD-LIST, --threads THREAD-LIST
-                        THREAD-LIST affected by commands
-.TP
 \fBtuna apply\fR
 usage: tuna-cmd.py apply [-h] profilename
 
diff --git a/po/ja.po b/po/ja.po
index 65006b1..9940d13 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -540,10 +540,6 @@ msgstr "ユーザースレッドを表示(_S)"
 msgid "_What is this?"
 msgstr "これは何?(_W)"
 
-#: tuna/gui/procview.py:559
-msgid "_Save kthreads tunings"
-msgstr "カーネルスレッド設定を保存(_S)"
-
 #: tuna/gui/irqview.py:117 tuna/gui/irqview.py:139
 msgid "IRQ"
 msgstr "IRQ"
@@ -651,11 +647,6 @@ msgstr "%(irqlist)s をコマンドの対象とする"
 msgid "FILENAME"
 msgstr "FILENAME"
 
-#: tuna-cmd.py:67
-#, python-format
-msgid "Save kthreads sched tunables to %(filename)s"
-msgstr "カーネルスレッドのスケジューラパラメータ設定を %(filename)s に保存"
-
 #: tuna-cmd.py:70 tuna-cmd.py:71
 msgid "CPU-SOCKET-LIST"
 msgstr "CPU-SOCKET-LIST"
diff --git a/po/pt_BR.po b/po/pt_BR.po
index c702ff9..3bcf1d4 100644
--- a/po/pt_BR.po
+++ b/po/pt_BR.po
@@ -442,10 +442,6 @@ msgstr "_Mostrar threads"
 msgid "_What is this?"
 msgstr "_O que é isto?"
 
-#: tuna/gui/procview.py:559
-msgid "_Save kthreads tunings"
-msgstr "_Salvar"
-
 #: tuna/gui/irqview.py:119 tuna/gui/irqview.py:141
 msgid "IRQ"
 msgstr ""
@@ -558,11 +554,6 @@ msgstr "%(irqlist)s afetada por comandos"
 msgid "FILENAME"
 msgstr "ARQUIVO"
 
-#: tuna-cmd.py:68
-#, python-format
-msgid "Save kthreads sched tunables to %(filename)s"
-msgstr "Salva opções configuráveis das threads do kernel em %(filename)s"
-
 #: tuna-cmd.py:71 tuna-cmd.py:72
 msgid "CPU-SOCKET-LIST"
 msgstr "LISTA-DE-SOCKETS-DE-CPUS"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index c76e22e..9086545 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -488,11 +488,6 @@ msgstr "显示用户线程（_S）"
 msgid "_What is this?"
 msgstr "这是什么？（_W）"
 
-#: tuna/gui/procview.py:559
-#, fuzzy
-msgid "_Save kthreads tunings"
-msgstr "保存内核调整（_S）"
-
 #: tuna/gui/irqview.py:119 tuna/gui/irqview.py:141
 msgid "IRQ"
 msgstr "中断"
@@ -600,11 +595,6 @@ msgstr "命令影响 %(irqlist)s"
 msgid "FILENAME"
 msgstr "文件名"
 
-#: tuna-cmd.py:67
-#, python-format
-msgid "Save kthreads sched tunables to %(filename)s"
-msgstr "保存内核线程调度参数到 %(filename)s"
-
 #: tuna-cmd.py:70 tuna-cmd.py:71
 msgid "CPU-SOCKET-LIST"
 msgstr "CPU套接字列表"
diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0a3e6b..a445470 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -93,7 +93,6 @@ def gen_parser():
     POS = {
             "cpu_list": dict(metavar='CPU-LIST', type=tuna.cpustring_to_list, help="CPU-LIST affected by commands"),
             "thread_list": dict(metavar='THREAD-LIST', type=threadstring_to_list, help="THREAD-LIST affected by commands"),
-            "filename": dict(metavar='FILENAME', type=str, help="Save kthreads sched tunables to this file"),
             "profilename": dict(type=str, help="Apply changes described in this file"),
             "run_command": dict(metavar='COMMAND', type=str, help="fork a new process and run the \"COMMAND\""),
             "priority": dict(type=tuna.get_policy_and_rtprio, metavar="POLICY:RTPRIO", help="Set thread scheduler tunables: POLICY and RTPRIO"),
@@ -148,8 +147,6 @@ def gen_parser():
                                     help="Set thread scheduler tunables: POLICY and RTPRIO")
     run = subparser.add_parser('run', description="Fork a new process and run the COMMAND",
                                 help="Fork a new process and run the COMMAND")
-    save = subparser.add_parser('save', description="Save kthreads sched tunables to FILENAME",
-                                help="Save kthreads sched tunables to FILENAME")
     apply = subparser.add_parser('apply', description="Apply changes described in profile",
                                 help="Apply changes described in profile")
     show_threads = subparser.add_parser('show_threads', description='Show thread list', help='Show thread list')
@@ -196,13 +193,6 @@ def gen_parser():
     run.add_argument('-p', '--priority', **MODS['priority'])
     run.add_argument('-b', '--background', **MODS['background'])
 
-    save.add_argument('filename', **POS['filename'])
-    save_group = save.add_mutually_exclusive_group(required=False)
-    save_group.add_argument('-c', '--cpus', **MODS['cpus'])
-    save_group.add_argument('-S', '--sockets', **MODS['sockets'])
-    save_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
-    save.add_argument('-t', '--threads', **MODS['threads'])
-
     apply.add_argument('profilename', **POS['profilename'])
 
     show_threads_group1 = show_threads.add_mutually_exclusive_group(required=False)
@@ -267,16 +257,6 @@ def thread_help(tid):
     print(help)
 
 
-def save(cpu_list, thread_list, filename):
-    kthreads = tuna.get_kthread_sched_tunings()
-    for name in list(kthreads.keys()):
-        kt = kthreads[name]
-        if (cpu_list and not set(kt.affinity).intersection(set(cpu_list))) or \
-           (thread_list and kt.pid not in thread_list):
-            del kthreads[name]
-    tuna.generate_rtgroups(filename, kthreads, utils.get_nr_cpus())
-
-
 def ps_show_header(has_ctxt_switch_info, cgroups=False):
     print("%7s %6s %5s %7s       %s" %
           (" ", " ", " ", _("thread"),
@@ -753,9 +733,6 @@ def main():
         if args.irq_list:
             tuna.move_irqs_to_cpu(args.cpu_list, args.irq_list, spread=spread)
 
-    elif args.command in ['s', 'save']:
-        save(args.cpu_list, args.thread_list, args.filename)
-
     elif args.command in ['W', 'what_is']:
         for tid in args.thread_list:
             thread_help(tid)
diff --git a/tuna/config.py b/tuna/config.py
index 63c9f23..67d2c72 100644
--- a/tuna/config.py
+++ b/tuna/config.py
@@ -320,56 +320,6 @@ class Config:
                 return tmpString
         return string
 
-    def saveSnapshot(self, data):
-        tempconfig = configparser.RawConfigParser()
-        tempconfig.readfp(io.StringIO(self.cache))
-        snapcat = tempconfig.items('categories')
-        out = {}
-        for opt, val in snapcat:
-            for index in range(len(data[val])):
-                data[val][index]['label'] = self.aliasToOriginal(
-                    data[val][index]['label'])
-                out[data[val][index]['label']] = data[val][index]['value']
-        for opt, val in snapcat:
-            snapcontPacked = tempconfig.items(opt)
-            snapcont = []
-            for index in range(len(snapcontPacked)):
-                if self.isFnString(snapcontPacked[index][0]):
-                    expanded = self.getFilesByFN("/proc/sys",
-                                                 self.ConfigPathToFileName(snapcontPacked[index][0]))
-                    for index2 in range(len(expanded)):
-                        expandedData = (self.FileNameToConfigPath(
-                            expanded[index2]), snapcontPacked[index][1])
-                        snapcont.append(expandedData)
-                else:
-                    snapcont.append(snapcontPacked[index])
-            for iopt, ival in snapcont:
-                if ival == '':
-                    tempconfig.set(opt, iopt, out[iopt])
-                elif ival == ',,':
-                    tempconfig.set(opt, iopt, ',,' + out[iopt])
-                else:
-                    reival = ival
-                    pos = [reival.start()
-                           for reival in re.finditer(',', reival)]
-                    if len(pos) == 2:
-                        ival = ival[0:pos[1]+1]
-                        tempconfig.set(opt, iopt, ival + out[iopt])
-                    else:
-                        tempconfig.set(opt, iopt, out[iopt])
-        if 'lastfile' in self.config:
-            self.name = self.config['lastfile'].replace('.conf', '')
-        else:
-            self.name = 'snapshot'
-        snapFileName = self.config['root'] + self.name \
-            + strftime("-%Y-%m-%d-%H:%M:%S", localtime()) + '.conf'
-        try:
-            with open(snapFileName, 'w') as configfile:
-                tempconfig.write(configfile)
-        except IOError:
-            print(_("Cant save snapshot"))
-        return snapFileName
-
     def checkConfigFile(self, filename):
         self.empty = True
         try:
diff --git a/tuna/gui/commonview.py b/tuna/gui/commonview.py
index 8089ed1..297fdb8 100644
--- a/tuna/gui/commonview.py
+++ b/tuna/gui/commonview.py
@@ -164,14 +164,6 @@ class commonview:
             ret = dialog.run()
             dialog.destroy()
 
-    def on_saveSnapshot_clicked(self, widget):
-        ret = self.guiSnapshot()
-        self.config.saveSnapshot(self.ret)
-        old_name = self.get_current_combo_selection()
-        if self.profileview.setProfileFileList():
-            self.profileview.set_current_tree_selection(old_name[1])
-            self.set_current_combo_selection(old_name[1])
-
     def on_saveTunedChanges_clicked(self, widget):
         if not self.config.checkTunedDaemon():
             dialog = Gtk.MessageDialog(None, \
diff --git a/tuna/gui/procview.py b/tuna/gui/procview.py
index 78d5f57..f3a1172 100755
--- a/tuna/gui/procview.py
+++ b/tuna/gui/procview.py
@@ -574,66 +574,6 @@ class procview:
     def refresh_toggle(self, a):
         self.refreshing = not self.refreshing
 
-    def save_kthreads_tunings(self, a):
-        dialog = Gtk.FileChooserDialog(_("Save As"), None, \
-            Gtk.FileChooserAction.SAVE, \
-            (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL, \
-            Gtk.STOCK_OK, Gtk.ResponseType.OK))
-        dialog.set_default_response(Gtk.ResponseType.OK)
-
-        try:
-            dialog.set_do_overwrite_confirmation(True)
-        except:
-            pass
-
-        filter = Gtk.FileFilter()
-        filter.set_name("rtctl config files")
-        filter.add_pattern("*.rtctl")
-        filter.add_pattern("*.tuna")
-        filter.add_pattern("*rtgroup*")
-        dialog.add_filter(filter)
-
-        filter = Gtk.FileFilter()
-        filter.set_name("All files")
-        filter.add_pattern("*")
-        dialog.add_filter(filter)
-
-        response = dialog.run()
-
-        filename = dialog.get_filename()
-        dialog.destroy()
-
-        if response != Gtk.ResponseType.OK:
-            return
-
-        self.refresh()
-        kthreads = tuna.get_kthread_sched_tunings(self.ps)
-        tuna.generate_rtgroups(filename, kthreads, self.nr_cpus)
-
-        if filename != "/etc/rtgroups":
-            dialog = Gtk.MessageDialog(None, \
-                Gtk.DialogFlags.MODAL | Gtk.DialogFlags.DESTROY_WITH_PARENT, \
-                Gtk.MessageType.INFO, Gtk.ButtonsType.YES_NO, \
-                "Kernel thread tunings saved!\n\n" \
-                "Now you can use it with rtctl:\n\n" \
-                "rtctl --file %s reset\n\n" \
-                "If you want the changes to be in " \
-                "effect every time you boot the system " \
-                "please move %s to /etc/rtgroups\n\n" \
-                "Do you want to do that now?" % (filename, filename))
-            response = dialog.run()
-            dialog.destroy()
-            if response == Gtk.ResponseType.YES:
-                filename = "/etc/rtgroups"
-                tuna.generate_rtgroups(filename, kthreads, self.nr_cpus)
-
-        dialog = Gtk.MessageDialog(None, \
-            Gtk.DialogFlags.MODAL | Gtk.DialogFlags.DESTROY_WITH_PARENT, \
-            Gtk.MessageType.INFO, Gtk.ButtonsType.OK, \
-            _("Kernel thread tunings saved to %s!") % filename)
-        dialog.run()
-        dialog.destroy()
-
     def on_processlist_button_press_event(self, treeview, event):
         if event.type != Gdk.EventType.BUTTON_PRESS or event.button != 3:
             return
@@ -661,24 +601,18 @@ class procview:
 
         help = Gtk.MenuItem(_("_What is this?"), use_underline = True)
 
-        save_kthreads_tunings = Gtk.MenuItem(_("_Save kthreads tunings"), use_underline = True)
-
-        menu.add(save_kthreads_tunings)
         menu.add(setattr)
         menu.add(refresh)
         menu.add(kthreads)
         menu.add(uthreads)
         menu.add(help)
 
-        save_kthreads_tunings.connect_object(
-            'activate', self.save_kthreads_tunings, event)
         setattr.connect_object('activate', self.edit_attributes, event)
         refresh.connect_object('activate', self.refresh_toggle, event)
         kthreads.connect_object('activate', self.kthreads_view_toggled, event)
         uthreads.connect_object('activate', self.uthreads_view_toggled, event)
         help.connect_object('activate', self.help_dialog, event)
 
-        save_kthreads_tunings.show()
         setattr.show()
         refresh.show()
         kthreads.show()
diff --git a/tuna/tuna.py b/tuna/tuna.py
index ef60c03..697e1d0 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -593,34 +593,6 @@ class sched_tunings:
         self.affinity = affinity
         self.percpu = percpu
 
-def get_kthread_sched_tunings(proc=None):
-    if not proc:
-        proc = procfs.pidstats()
-
-    kthreads = {}
-    for pid in list(proc.keys()):
-        name = proc[pid]["stat"]["comm"]
-        # Trying to set the priority of the migration threads will
-        # fail, at least on 3.6.0-rc1 and doesn't make sense anyway
-        # and this function is only used to save those priorities
-        # to reset them using tools like rtctl, skip those to
-        # avoid sched_setscheduler/chrt to fail
-        if iskthread(pid) and not name.startswith("migration/"):
-            rtprio = int(proc[pid]["stat"]["rt_priority"])
-            try:
-                policy = os.sched_getscheduler(pid)
-                affinity = os.sched_getaffinity(pid)
-            except OSError as err:
-                if err.args[0] == errno.ESRCH:
-                    continue
-                raise err
-            percpu = iskthread(pid) and \
-                 proc.is_bound_to_cpu(pid)
-            kthreads[name] = sched_tunings(name, pid, policy, rtprio,
-                                           affinity, percpu)
-
-    return kthreads
-
 def run_command(cmd, policy, rtprio, cpu_list, background):
     newpid = os.fork()
     if newpid == 0:
@@ -648,69 +620,5 @@ def run_command(cmd, policy, rtprio, cpu_list, background):
         if not background:
             os.waitpid(newpid, 0)
 
-def generate_rtgroups(filename, kthreads, nr_cpus):
-    f = open(filename, "w")
-    f.write('''# Generated by tuna
-#
-# Use it with rtctl:
-#
-# rtctl --file %s reset
-#
-# Please use 'man rtctl' for more operations
-#
-# Associate processes into named groups with default priority and
-# scheduling policy.
-#
-# Format is: <groupname>:<sched>:<prio>:<regex>
-#
-# groupname must start at beginning of line.
-# sched must be one of: 'f' (fifo)
-#                       'b' (batch)
-#                       'r' (round-robin)
-#                       'o' (other)
-#                       '*' (leave alone)
-# regex is an awk regex
-#
-# The regex is matched against process names as printed by "ps -eo cmd".
-
-''' % filename)
-    f.write(r"kthreads:*:1:*:\[.*\]$" + "\n\n")
-
-    per_cpu_kthreads = []
-    names = list(kthreads.keys())
-    names.sort()
-    for name in names:
-        kt = kthreads[name]
-        try:
-            idx = name.index("/")
-            common = name[:idx]
-            if common in per_cpu_kthreads:
-                continue
-            per_cpu_kthreads.append(common)
-            name = common
-            if common[:5] == "sirq-":
-                common = "(sirq|softirq)" + common[4:]
-            elif common[:8] == "softirq-":
-                common = "(sirq|softirq)" + common[7:]
-                name = "s" + name[4:]
-            regex = common + r"\/.*"
-        except:
-            idx = 0
-            regex = name
-        if kt.percpu or idx != 0 or name == "posix_cpu_timer":
-            # Don't mess with workqueues, etc
-            # posix_cpu_timer is too long and doesn't
-            # have PF_THREAD_BOUND in its per process
-            # flags...
-            mask = "*"
-        else:
-            mask = ",".join([hex(a) for a in \
-                     procfs.hexbitmask(kt.affinity, nr_cpus)])
-        f.write(r"%s:%c:%d:%s:\[%s\]$" % (name, \
-                           tuna_sched.sched_str(kt.policy)[6].lower(), \
-                            kt.rtprio, mask, regex) + "\n")
-    f.close()
-
-
 def nohz_full_list():
     return [int(cpu) for cpu in procfs.cmdline().options["nohz_full"].split(",")]
diff --git a/tuna/tuna_gui.glade b/tuna/tuna_gui.glade
index 1ddcf12..d01a6a6 100644
--- a/tuna/tuna_gui.glade
+++ b/tuna/tuna_gui.glade
@@ -210,61 +210,6 @@
                               <object class="GtkHBox" id="controls-sub">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
-                                <child>
-                                  <object class="GtkButton" id="saveChanges">
-                                    <property name="width_request">150</property>
-                                    <property name="visible">True</property>
-                                    <property name="can_focus">True</property>
-                                    <property name="receives_default">True</property>
-                                    <property name="has_tooltip">True</property>
-                                    <signal name="clicked" handler="on_saveSnapshot_clicked" swapped="no"/>
-                                    <child>
-                                      <object class="GtkAlignment" id="alignment14">
-                                        <property name="visible">True</property>
-                                        <property name="can_focus">False</property>
-                                        <property name="xscale">0</property>
-                                        <property name="yscale">0</property>
-                                        <child>
-                                          <object class="GtkHBox" id="hbox10">
-                                            <property name="visible">True</property>
-                                            <property name="can_focus">False</property>
-                                            <property name="spacing">2</property>
-                                            <child>
-                                              <object class="GtkImage" id="image3">
-                                                <property name="visible">True</property>
-                                                <property name="can_focus">False</property>
-                                                <property name="stock">gtk-save</property>
-                                              </object>
-                                              <packing>
-                                                <property name="expand">False</property>
-                                                <property name="fill">False</property>
-                                                <property name="position">0</property>
-                                              </packing>
-                                            </child>
-                                            <child>
-                                              <object class="GtkLabel" id="label18">
-                                                <property name="visible">True</property>
-                                                <property name="can_focus">False</property>
-                                                <property name="label" translatable="yes">Save Snapshot</property>
-                                                <property name="use_underline">True</property>
-                                              </object>
-                                              <packing>
-                                                <property name="expand">False</property>
-                                                <property name="fill">False</property>
-                                                <property name="position">1</property>
-                                              </packing>
-                                            </child>
-                                          </object>
-                                        </child>
-                                      </object>
-                                    </child>
-                                  </object>
-                                  <packing>
-                                    <property name="expand">True</property>
-                                    <property name="fill">False</property>
-                                    <property name="position">0</property>
-                                  </packing>
-                                </child>
                                 <child>
                                   <object class="GtkButton" id="saveTunedChanges">
                                     <property name="width_request">220</property>
diff --git a/tuna/tuna_gui.py b/tuna/tuna_gui.py
index cefee4a..2041568 100755
--- a/tuna/tuna_gui.py
+++ b/tuna/tuna_gui.py
@@ -92,8 +92,6 @@ class main_gui:
             : self.commonview.on_applyChanges_clicked,
             "on_undoChanges_clicked"
             : self.commonview.on_undoChanges_clicked,
-            "on_saveSnapshot_clicked"
-            : self.commonview.on_saveSnapshot_clicked,
             "on_saveTunedChanges_clicked"
             : self.commonview.on_saveTunedChanges_clicked,
             "on_profileSelector_changed"
-- 
2.51.0

