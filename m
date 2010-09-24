From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: regarding synchronization code
Date: Fri, 24 Sep 2010 17:58:43 -0600
Message-ID: <4C9D02F30200005A00072B73@soto.provo.novell.com>
References: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: "Sri Ram Vemulpali" <sri.ram.gmu06@gmail.com>,
	"Kernel-newbies" <kernelnewbies@nl.linux.org>,
	"Linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On 9/24/2010 at 06:56 PM, in message
<AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>, Sri Ram
Vemulpali <sri.ram.gmu06@gmail.com> wrote: 
> Hi all,
> 
>   I am encountering alot macros in the code. I did not understand what
> those macro means.
> 
>   Can anyone explain them and the use of them putting them like that.
> 
>    "unlikely"

Related to gcc branch-prediction, iirc.

>    "always_inline"  -- defined at the signature of the function.
>    "inline" -- I know inline keyword in compiler is used to place the
> code in to the caller function at the time of compiler, but why
> declared as macro

Probably so it can be enabled/disabled as a .config option.

Kind Regards,
-Greg

