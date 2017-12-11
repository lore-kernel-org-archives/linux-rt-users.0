From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/9] Revert "fs: jbd2: pull your plug when waiting for
 space"
Date: Mon, 11 Dec 2017 17:02:48 +0100
Message-ID: <20171211160248.ttui5l5fjac37abf@linutronix.de>
References: <20171202013658.149533964@goodmis.org>
 <20171202013711.424595897@goodmis.org>
 <20171204084545.GB2255@linutronix.de>
 <20171208131524.2099b1fd@vmware.local.home>
 <20171211153709.sa2tdk6xro6ccaxy@linutronix.de>
 <20171211105306.52cdf62f@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171211105306.52cdf62f@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-11 10:53:06 [-0500], Steven Rostedt wrote:
> 
> Yep. Not sure why I didn't include it in 4.4. I added it to my queue,
> and started testing it, which is one of the reasons I haven't posted it
> yet. Also, my internet connectivity has be really poor while traveling
> this time.

Ah okay then. I misunderstood you then as I though that you would skip
that patch and the revert (and keep things as they are). Sorry for that.

> -- Steve

Sebastian
