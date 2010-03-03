From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] =?UTF-8?q?mm/highmem.c:=20Fix=20=E2=80=98pkmap=5Fcount=E2=80=99=20undeclared?=
Date: Wed,  3 Mar 2010 23:49:06 +0100
Message-ID: <1267656546-19173-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Xavier Miller <xavier.miller@cauwe.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	Carsten Emde <ce@ceag.ch>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:65086 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0CCWtP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Mar 2010 17:49:15 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This fixes the following problem that occurs when CONFIG_DEBUG_VM=3Dy

mm/highmem.c:534: error: =E2=80=98pkmap_count=E2=80=99 undeclared (firs=
t use in this function)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mm/highmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 1b534a8..887a487 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -531,7 +531,7 @@ static int __set_page_address(struct page *page, vo=
id *virtual, int pos)
 	struct page_address_map *pam;
=20
 	VM_BUG_ON(!PageHighMem(page));
-	VM_BUG_ON(atomic_read(&pkmap_count[pos]) !=3D 0);
+	VM_BUG_ON(atomic_read(&pkmap[pos].count) !=3D 0);
 	VM_BUG_ON(pos < 0 || pos >=3D LAST_PKMAP);
=20
 	pas =3D page_slot(page);
--=20
1.6.5.7

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
