From: yunhong jiang <yunhong.jiang@linux.intel.com>
Subject: The timer softirq on the RT kernel
Date: Thu, 4 Aug 2016 17:36:41 -0700
Message-ID: <20160804173641.4defb00b@jnakajim-build>
References: <CAC6yHM4kTvXiJwsyFqmi3p_4U8a54wwUJz9QFHAGsO+aM6G6Wg@mail.gmail.com>
	<DDCAE26804250545B9934A2056554AA021106A54@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org
To: umgwanakikbuti@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DDCAE26804250545B9934A2056554AA021106A54@ORSMSX112.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,Mike & Steven
	On https://lkml.org/lkml/2015/3/24/1178, the patch of "timers:
do not raise softirq unconditionally" is reverted. Thanks for Steven's
detailed comments, it's quite clear explained.
	I remember Mike has a patch trying to fix it but late
abandoned. Do you still have any plan to work on this? Otherwise, I
will have a try.
	
Thanks
--jyh
