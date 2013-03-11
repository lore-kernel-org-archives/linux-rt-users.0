From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Threaded irqs + 100% CPU RT task = RCU stall
Date: Mon, 11 Mar 2013 18:54:08 +0100
Message-ID: <20130311175408.GC22286@linutronix.de>
References: <20130306154917.GA15249@windriver.com>
 <alpine.LFD.2.02.1303061651360.22263@ionos>
 <20130306171648.GO3268@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1303062010060.22263@ionos>
 <20130306214502.GC3268@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130306214502.GC3268@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Paul E. McKenney | 2013-03-06 13:45:02 [-0800]:

>Is this behavior OK?  If so, the following (untested) patch might do
>what you want.  ;-)

Paul (Gortmaker) could you please test Paul's (McKenney) to see if it
makes things for Joe (Average) easier to spot?

Sebastian
