From: jordan <triplesquarednine@gmail.com>
Subject: Re: BUG: spinlock trylock failure on UP - reverting timer patches
 helps
Date: Thu, 17 Apr 2014 21:15:50 -0400
Message-ID: <CAOcfFMz6U+w_h+0GoAB4OMbEGsDo_h=vCobvgxuBtLTijW3VmQ@mail.gmail.com>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org> <53500184.4050309@meduna.org>
 <53505BD7.9050004@meduna.org>
 <CAOcfFMyTmQH-FwGE2YWoA76ypzBtWPYVTyi+4QpEMnrRtw8QVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOcfFMyTmQH-FwGE2YWoA76ypzBtWPYVTyi+4QpEMnrRtw8QVg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

Hey again,

> [ninez@localhost ~]$  (cat /proc/meminfo ; cat /proc/meminfo) |  grep
> KernelStack
> KernelStack:        3728 kB
> KernelStack:        3728 kB
> [ninez@localhost ~]$  (cat /proc/meminfo ; cat /proc/meminfo) |  grep
> KernelStack
> KernelStack:        3696 kB
> KernelStack:        3696 kB
>
> I'll post from my old kernel in a bit.

my other machines all report kstack as being stable/consistent - I
also had an Archlinux user of my kernel check his box - his was
consistent too. [all of those boxes reverted those timer patches].

cheerz

Jordan
