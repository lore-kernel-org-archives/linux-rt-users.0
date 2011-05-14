From: John Kacur <jkacur@redhat.com>
Subject: [stable] Patch for 2.6.33
Date: Sat, 14 May 2011 17:47:25 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1105141740040.29326@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: stable@kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: gregkh@suse.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757560Ab1ENPsL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 May 2011 11:48:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I merging the latest 2.6.33.13 stable branch into the real-time kernel and 
using a distro with a make 3.82, and needed to cherry-pick the following 
commit in order to compile. Please consider picking it up for 2.6.33.y 
stable.

Thanks
John

>From cbbe989bf5f3c8d4671b0c008022a8b718a3c082 Mon Sep 17 00:00:00 2001
From: Jan Beulich <JBeulich@novell.com>
Date: Mon, 16 Aug 2010 11:58:58 +0100
Subject: [PATCH] fixes for using make 3.82

commit 3c955b407a084810f57260d61548cc92c14bc627 upstream

It doesn't like pattern and explicit rules to be on the same line,
and it seems to be more picky when matching file (or really directory)
names with different numbers of trailing slashes.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Andrew Benton <b3nton@gmail.com>
Cc: <stable@kernel.org>
Signed-off-by: Michal Marek <mmarek@suse.cz>
Cherry-picked-for: rt/2.6.33
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 firmware/Makefile  |    2 +-
 scripts/mkmakefile |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/firmware/Makefile b/firmware/Makefile
index 1c00d05..087e45b 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -141,7 +141,7 @@ fw-shipped-$(CONFIG_YAM) += yam/1200.bin yam/9600.bin
 fw-shipped-all := $(fw-shipped-y) $(fw-shipped-m) $(fw-shipped-)
 
 # Directories which we _might_ need to create, so we have a rule for them.
-firmware-dirs := $(sort $(patsubst %,$(objtree)/$(obj)/%/,$(dir $(fw-external-y) $(fw-shipped-all))))
+firmware-dirs := $(sort $(addprefix $(objtree)/$(obj)/,$(dir $(fw-external-y) $(fw-shipped-all))))
 
 quiet_cmd_mkdir = MKDIR   $(patsubst $(objtree)/%,%,$@)
       cmd_mkdir = mkdir -p $@
diff --git a/scripts/mkmakefile b/scripts/mkmakefile
index 67d59c7..5325423 100644
--- a/scripts/mkmakefile
+++ b/scripts/mkmakefile
@@ -44,7 +44,9 @@ all:
 
 Makefile:;
 
-\$(all) %/: all
+\$(all): all
 	@:
 
+%/: all
+	@:
 EOF
-- 
1.7.2.3

