From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH ]cyclictest: fix invalid comment of debugfs mount
	directory.
Date: Mon, 1 Jun 2009 09:01:41 -0300
Message-ID: <20090601120141.GQ21851@unix.sh>
References: <1243821987.20635.42.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:40368 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827AbZFAMCH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Jun 2009 08:02:07 -0400
Received: by pxi29 with SMTP id 29so2712239pxi.33
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Jun 2009 05:02:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1243821987.20635.42.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 01, 2009 at 11:06:27AM +0900, GeunSik Lim wrote:
| 
| 
| Dear Clark Williams, 
| 
| Please, Fix the "debugfs/tracing" name in cyclictest.c source file. 
| 
| P.S: Now, version is differenct between shortlog(v0.39) and tags(v0.40). 
|      Maybe, You have to check version name of shortlog table. 
|      http://git.kernel.org/?p=linux/kernel/git/clrkwllms/rt-tests.git;a=summary
| 
| Thanks,
| GeunSik Lim. 
| 
| 
| 
| Subject: [PATCH ]cyclictest: Fix invalid comment of debugfs mount directory.
| 
| The "debugfs/tracing" name is invalid.
| Example,
| #> mount -t debugfs nodev /sys/kernel/debug [enter]
| #> ln -s /sys/kernel/debug /debug [enter]
| 
| Fix directory name normally from debugfs/tracing to debug/tracing.

GeunSik,

I would suggest changing your comment in the patch to something like:

	/* finds the path to the tracing dir inside debugfs mountpoint */

Because it is not written in the stone where debugfs should be mounted.
There is a suggested place, that already changed at least twice. So, the
function locates the debugfs mountpoint, wherever it is and looks for the
tracing directory.

Luis


|          Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
| ---
|  src/cyclictest/cyclictest.c |    2 +-
|  1 files changed, 1 insertions(+), 1 deletions(-)
| 
| diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
| index be9a3f9..32a120a 100644
| --- a/src/cyclictest/cyclictest.c
| +++ b/src/cyclictest/cyclictest.c
| @@ -179,7 +179,7 @@ static char functiontracer[MAX_PATH];
|  static char traceroptions[MAX_PATH];
|  
|  /*
| - * Finds the path to the debugfs/tracing
| + * Finds the path to the debug/tracing
|   */
|  static int set_debugfileprefix(void)
|  {
| -- 
| 1.6.3.1

-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

