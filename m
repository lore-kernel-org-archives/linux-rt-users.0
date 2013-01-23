From: Christoph Lameter <cl@linux.com>
Subject: FIX [0/2] Slub hot path fixes
Date: Wed, 23 Jan 2013 21:45:47 +0000
Message-ID: <0000013c695fbbe8-6a7f750f-4647-40b8-9ab3-f4fa5af8c382-000000@email.amazonses.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
To: Pekka Enberg <penberg@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from a194-210.smtp-out.amazonses.com ([199.255.194.210]:6805 "EHLO
	a194-210.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab3AWVzf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jan 2013 16:55:35 -0500
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <clark@redhat.com>
Cc: John Kacur <jkacur@gmail.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Joonsoo Kim <js1304@gmail.com>
Cc: Glauber Costa <glommer@parallels.com>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: elezegarcia@gmail.com
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These are patches to fix up the issues brought up by Steven Rostedt.

I hoped to avoid the preempt disable for the tid retrieval but there is
no per cpu atomic way to get a value from the per cpu area and also retrieve
the pointer used in that operation. The pointer is necessary to fetch the
related data from the per cpu structure. Without that we
run into more issues with page pointer checks that can cause
freelist corruption in slab_free().

