Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DA36CDF8
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258386; cv=none; b=f6g3fRJsScpW1lSfmzkgtRHh2hvP2lOAF+n8XHRVfAiT0aDiwdwCx42rSvCKpt3ipl5MviVhbMI8Hhl0QKCK4rROw2V/Jrxm3s6TpDsgSzlIdimsoX5gIqPN11dP/XjpUNaeaF3/iJmEhWqdGbLGWPokfRWLVNKcT1H1Cfr/qWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258386; c=relaxed/simple;
	bh=qT83S9YBP40o2V98YGLVTHS8HE6y21QtUUO7HEytNec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9MMiu3nKxkS6ozMFJs7RErL4mK8mHWwAJ0bjrAmYGKNgqvlQMomLhpb8kdYXl4Nr8+r2LpuUk5TUG/UGR+B1ojt4WVwl7A/EE6bieXayzg8qmKFNNFtjeNhRxW0c4mPrFYEsLtThwMBXn66CV9ymF+A3ZtKrMih+ielgp4zN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSs36m9W; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSs36m9W"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f186025973so334766d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258384; x=1785863184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ICeQDev6mhi5xb/rkqKCp+pN/xLyUqI3wA3/afTT8E=;
        b=DSs36m9WH3HQzy8wYjmjA/ap1M7U+oujAgJK886dc5U3P4HuZXuHjWJpsxXmiwks4D
         OQYGWS55EUqvhFiNGmv1aDrG42uzIp/rhvHbadLqImSpf43eFCsTWZgFqP+WUiJS3gpi
         VIxGf5RVJxmo29B8JYO3ZcUZCFX/rT3928g7P1EsKzQq6+nYIBGaZYoUaMyBXws7QzpN
         JtRNIsh3siFlS4klqqj3rluIJ6nIZmd3uz4y3KSZp1CtotekuQZ493ISF1wDuwLxZ7fS
         gW5fmOlqulL8joEkdLgR4QTCJbcsUztLGrSJ0v9Edn/s8LunSODx+ViM2xxQK4vY/NK3
         Qong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258384; x=1785863184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ICeQDev6mhi5xb/rkqKCp+pN/xLyUqI3wA3/afTT8E=;
        b=NQ6POqTnT59SlUrJFA1/4JbCdXnxawILf0kIvXPCLkx1UfjJkV8K+jUmriv0AdeUBA
         7KQFwpJ3irEmRes0y6aQfwFajjctTZmjYe+U+sJkjmfqDgbzXhv/S1qlL7VkupxHrdwq
         lp2kxSvC8BCLeFJ4K0n1V+uzq8tP7M9TeZZLoYPNA2q3QCoIhSFjiobiyYacwhpOFoLe
         3o4kZw4o2NXmTOvadZF+/drt7eLvdUJMy+DNBJuSrppI2aHXpcjLvRooaZ14jvTG5616
         8/snoa6I7bZxnwbQMu6cF5BzZ8vFQaNNZ/dJupdIsncpqboFU85cmKWsP9beejsQBhT7
         0xtA==
X-Gm-Message-State: AOJu0YxuSGGrx5kc3vD624utCrBvZ7CT8GMEDClMxGvuk+j/hixKcx+B
	sXeNDyaLcWwYA5iPS4tHsuEWRDG4wO+xpoywREkYNSv25M00ShqX3iGCkQjlWQ==
X-Gm-Gg: AR+sD13MB/QrEv9lKQElKw9YD3SBOTy1V0cymnwkMIH8xFINVHS9uGPNfzPWF7hhS2q
	/oZ49wWi2Qur0X4LxvbL4AMXmn5Hjd3GgxMU8vc4/Uujkbd+xfKixWwZOZ54FLYCTNw/fisDje5
	oaOxweFEbt0hVgmi/xtePhXxJ4foV5QW63hQw/+Szdzwq4VvIZ1Xt1EhI5qDvxtj1mOOFtK5skr
	19vA8YrTSGrFCMDi8fVpEbKWkjCewOby6ke72+QLXznzro0lX8UIVyDK+iriYdVy7uZNR3i1elu
	CdCO27NnK0Cc4yARSScxf1aZtfFwM3Wg4ZRI2pj9IVtbaI5njdAg29XMtaWCyjGAL+aUh/xMpfK
	oRSMc5/8iwWEyERRlDH6DjYPASMBK06M6GwbETc+eJU9U0pw1VQc/3mrbES4Z+dYblna8pHLubK
	kXlKy1eEt/fPhzEGWmgdYsNSg+BO/sa8TWyWFt0lazXWfGZ2qEgjqqRB6EiJJxp6Ua0ozD
X-Received: by 2002:a05:6214:212a:b0:8fe:9e2d:ce4f with SMTP id 6a1803df08f44-908173a1616mr41168546d6.65.1785258383780;
        Tue, 28 Jul 2026 10:06:23 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3aac2sm3229676d6.30.2026.07.28.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:06:23 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 1/5] tuna: Remove obsolete ChangeLog file
Date: Tue, 28 Jul 2026 13:06:03 -0400
Message-ID: <20260728170607.176811-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170607.176811-1-jkacur@redhat.com>
References: <20260728170607.176811-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ChangeLog file has not been updated since February 2013 (v0.10.4),
making it obsolete and potentially misleading. With 58 commits since
v0.20 alone, maintaining a separate ChangeLog is impractical.

Users can view the complete commit history with git log, which provides
more accurate and detailed information about changes.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 ChangeLog | 152 ------------------------------------------------------
 1 file changed, 152 deletions(-)
 delete mode 100644 ChangeLog

diff --git a/ChangeLog b/ChangeLog
deleted file mode 100644
index 969f2fca8e63..000000000000
--- a/ChangeLog
+++ /dev/null
@@ -1,152 +0,0 @@
-* Fri Feb  1 2013 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.4-1
-
-63580be procview: Allow configuring a single thread
- Fixes https://bugzilla.redhat.com/show_bug.cgi?id=601234
-5d4ee70 tuna: Tighten "No such process" schedutils exception handling
-cca561d tuna: Catch OSError exceptions from python-schedutils
- Fixes https://bugzilla.redhat.com/show_bug.cgi?id=871598
-07907b3 tuna: Add man page for command line
-
-* Fri Aug 24 2012 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.3-1
-
-. Fix exception on ARM
-. Remove raw cycles column when perf events are used
-. Don't touch the migration threads
-. Update testuna to work with 3.6.0-rc1
-
-* Thu Jul 28 2011 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.2-1
-
-[acme@felicio tuna]$ git log v0.10.1.. --format=oneline --abbrev-commit
-ddd2754 oscilloscope: Switch from "Bistream Vera Sans" to "Liberation Sans"
-c5c558c oscilloscope: Switch from Numeric to numpy
-28d87b6 MANIFEST: Add tuna/oscilloscope.py
-4de7144 cmdline: Fix IRQ affinity setting
-40bc92d procview gui: Load perf globally
-
-* Wed Feb 23 2011 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.1-1
-
-24f19ce procview gui: Don't assume the perf binding is always available
-
-* Wed Feb 23 2011 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10-1
-
-[acme@emilia tuna]$ git log v0.9.4.. --format=oneline --abbrev-commit
-3b54abd perf: Create the threads pidstat member when we notice the first thread
-04f26d1 gui: Fixup perf.evlist constructor call
-00a2aa4 gui: Use perf if available
-f130d84 cmdline: Alert the user when GUI packages are not installed
-
-* Mon May 10 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9.3-1
-
-[acme@mica tuna]$ git log v0.9.2.. --format=oneline --abbrev-commit
-7d4f258 cmdline: Emit error when affinity operation can't be performed
-a9e68d1 cmdline: Use tuna.cpustring_to_list in --cpus
-21de19e tuna: Make is_hardirq_handler handle non thread group leaders
-ab01211 cmdline: Handle unknown schedulers in -p/--priority:
-bbdaf5a cmdline: Improve message about thread list being needed by -p/--priority
-427f94c cmdline: Fix --priority error message when no threads are informed
-85bb5d7 cmdline: Fix help line entry for --priority
-6d0288b tuna: Make cpustring_to_list understand 0x prefixed hexadecimal numbers
-7210b53 gui: fix use of cpu ranges
-f2bc415 irqview: Fix some race conditions
-a3e85fe cmdline: On threaded irq kernels, map irqs to threads
-7d33dd1 cmdline: Fix threaded interrupt name bug
-3a71dae cmdline: --priority/-p requires a thread list
-[acme@mica tuna]$
-
-* Thu Nov 12 2009 Arnaldo Carvalho de Melo <acme@redhat.com>
-- cmdline: -Q --show_irqs shows IRQs, so that we can see its affinity
-  masks even on non-threaded IRQ kernels
-- tuna: Ignore non-existing threads in threads_set_priority
-- tuna: i18n, Chinese
-
-* Thu Sep  3 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9.1-1
-- cmdline: --socket needs an argument
-- tuna: Present more graceful failure mode when machine can't start gui
-- tuna: Handle 2.6.31 style threaded irq names
-
-* Wed May 13 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9-1
-- tuna: i18n, pt_BR & Japanese
-- oscilloscope: Fix scaling bugs and add --sample_multiplier
-- oscilloscope: properly refresh all widgets
-- oscilloscope: Remove needless shebang and reword the package summary
-- cmdline: add --show_sockets/-n
-
-* Mon Oct 27 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.8.4-1
-- cmdline: Allow globbing --irqs/-q
-- cmdline: Allow globbing --threads/-t
-- cmdline: Support regex on --thread
-- cmdline: Check if thread names resolved to TIDs
-- irqview: We have to pass an int to schedutils.setscheduler
-- irqview: Initialize the rt_prio entry box
-- gui: move procview to a separate file
-- gui: Move irqview to a separate file
-- gui: remove the Set/set trick in tuna/tuna_gui.py, not used anymore
-- gui: Use schedutils.SCHED_{OTHER,FIFO,RR}
-- gui: move cpuview classes to a separate file
-- gui: Stop handling exceptions at procview.set_thread_columns
-- oscilloscope: Ignore invalid samples, emitting just a warning
-
-* Mon Oct 27 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.8-1
-- [Non]VolCtxtSwitch columns should be represented in the GUI as unsigned
-- Several spelling fixes
-- Handle some more schedutils exceptions
-- Fix getopt long option for --priority, it requires an arg
-- Set the irq affinity mask when setting a IRQ thread affinity
-- Add a --spread command line option, it will spread the threads
-  passed thru --threads into the cpus specified in --cpu or --socket.
-
-* Mon Sep 15 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.7-1
-- CPU topology support: operations now can be performed on CPU sockets in
-  addition to individual CPUs
-- --show_threads: command line now can see the same information available
-  in the GUI
-
-* Tue Aug 12 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.6-1
-- tuna: posix_cpu_timer is percpu but its too long to have '/' in the cmdline
-- tuna: Fixup the message about what filename was really used (rtgroups)
-- tuna: Save the affinity mask for non-percpu kthreads
-- tuna: Ignore rtprio when changing sched policy to SCHED_OTHER
-
-* Thu Aug  7 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.5-1
-- tuna_gui: Provide instructions on how to use the generated rtctl file
-- tuna_gui: Add "Save kthreads tunings" menu entry in the process list box
-- tuna: Implement saving current kthread sched policy and rtprio as an rtctl file
-- help: Add more kernel thread help texts, written by the MRG crew
-
-* Tue Jun 17 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.4-1
-- oscilloscope subpackage
-- oscilloscope: Allow passing the number of samples to appear on screen
-- oscilloscope: use io_add_watch instead of timeout_add
-- oscilloscope: check if the latency tracer is available
-- oscilloscope: Allow disabling auto-scaling
-- oscilloscope: group the system info and help frames in a vbox
-- oscilloscope: parse X geometry parameter
-- tuna: Convert widget coords to bin_window coords
-- tuna: Implement --affect_children and --priority
-
-* Fri May 16 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.3-1
-- Add oscilloscope command, initially useful with signaltest and cyclictest,
-  but will also be used with the latencytest utility in the qpid project and
-  with any other source of signals. Requires python-matplotlib, that will
-  be added to the MRG repo soon. 
-- Allow toggling auto-refresh from the irq and threads views
-- Changes to make tuna work on older RHEL versions, helpful when evaluating
-  RHEL-RT components.
-- Allow using tuna without GUI libraries installed, please see:
-  tuna --help
-  For available commands.
-- Several fixes
-
-* Thu Mar 27 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.2-1
-- Command line interface
-- Remove the requirement of a GUI packages
-- Allow moving one child thread to a CPU
-- Status icon
-- "What is this?", for now just for some kernel threads
-- Add "Restore CPU" to undo "Isolate CPU"
-- Faster CPU isolation process
-- Allow moving IRQs & Threads to all cpus
-- CPU filtering
-
-* Mon Feb 26 2008 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.1-1
-- package created
-- 
2.55.0

