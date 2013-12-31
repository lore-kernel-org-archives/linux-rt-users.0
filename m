From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: RE: [PATCH RT] add missing local serialization in ip_output.c
Date: Tue, 31 Dec 2013 07:36:20 +0000
Message-ID: <C9F8415089354E4FB76F4548B3515AF476ADD75F@edb1.wapice.localdomain>
References: <20131229171154.GA23586@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?iso-8859-1?Q?Sami_Pietik=E4inen?= <Sami.Pietikainen@wapice.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>
To: Nicholas Mc Guire <der.herr@hofr.at>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131229171154.GA23586@opentech.at>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

I confirm that this patch works. Tested it overnight with Zedboard (Cortex A9). Thanks again!

BR,
Jouko