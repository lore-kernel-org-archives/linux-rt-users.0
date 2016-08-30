From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] mlock.2: document that is a bad idea to fork() after mlock()
Date: Tue, 30 Aug 2016 10:59:11 +0200
Message-ID: <20160830085911.5336-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

fork() will remove the write PTE bit from the page table on each VMA
which will be copied via COW. A such such, the memory is available but
marked read only in the page table and will fault on write access.
This renders the previous mlock() operation almost useless because in a
multi threaded application the RT thread may block on mmap_sem while the
thread with low priority is holding the mmap_sem (for instance because
it is allocating memory which needs to be mapped in).

There is actually nothing we can do to mitigate the outcome. We could
add a warning to the kernel for people that are not yet aware of the
updated documentation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 man2/mlock.2 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/man2/mlock.2 b/man2/mlock.2
index e34bb3b4e045..27f80f6664ef 100644
--- a/man2/mlock.2
+++ b/man2/mlock.2
@@ -350,6 +350,20 @@ settings are not inherited by a child created via
 and are cleared during an
 .BR execve (2).
=20
+Note that
+.BR fork (2)
+will prepare the address space for a copy-on-write operation. The conseque=
nce
+is that any write access that follows will cause a page fault which in tur=
n may
+cause high latencies for a real-time process. Therefore it is crucial not =
to
+invoke
+.BR fork (2)
+after the
+.BR mlockall ()
+or
+.BR mlock ()
+operation not even from thread which runs at a low priority within a proce=
ss
+which also has a thread running at elevated priority.
+
 The memory lock on an address range is automatically removed
 if the address range is unmapped via
 .BR munmap (2).
--=20
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
