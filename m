From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 0/3] per-CPU vmstat thresholds and vmstat worker disablement (v2)
Date: Wed, 03 May 2017 15:40:07 -0300
Message-ID: <20170503184007.174707977@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Rik van Riel <riel@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

The per-CPU vmstat worker is a problem on -RT workloads (because
ideally the CPU is entirely reserved for the -RT app, without
interference). The worker transfers accumulated per-CPU
vmstat counters to global counters.

To resolve the problem, create two tunables:

* Userspace configurable per-CPU vmstat threshold: by default the
VM code calculates the size of the per-CPU vmstat arrays. This
tunable allows userspace to configure the values.

* Userspace configurable per-CPU vmstat worker: allow disabling
the per-CPU vmstat worker.

v2:
- Improve documentation (Rik/Luiz).
- Split patch in two (Luiz).
- Fix comparison to include equal, in the helpers for
stats accounting.



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
