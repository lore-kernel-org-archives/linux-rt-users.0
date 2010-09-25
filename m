From: Michael Blizek <michi1@michaelblizek.twilightparadox.com>
Subject: Re: regarding synchronization code
Date: Sat, 25 Sep 2010 10:48:16 +0200
Message-ID: <20100925084816.GA2946@michaelblizek.twilightparadox.com>
References: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Return-path: <kernelnewbies-bounce@nl.linux.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Sender: kernelnewbies-bounce@nl.linux.org
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
List-Id: linux-rt-users.vger.kernel.org

Hi!

On 18:56 Fri 24 Sep     , Sri Ram Vemulpali wrote:
> Hi all,
> 
>   I am encountering alot macros in the code. I did not understand what
> those macro means.
> 
>   Can anyone explain them and the use of them putting them like that.
> 
>    "unlikely"

likely() and unlikely() are wrappers around gcc extensions to give hints about
whether a given branch will likely be taken or not. When done correctly, this
can improve performance.

>    "always_inline"  -- defined at the signature of the function.

This can be used because "inline" is not always inlined. There should be a gcc
option which causes all inline code to be not inlined.

>    "inline" -- I know inline keyword in compiler is used to place the
> code in to the caller function at the time of compiler, but why
> declared as macro

Where do you see inline declared as a macro?

	-Michi
-- 
programing a layer 3+4 network protocol for mesh networks
see http://michaelblizek.twilightparadox.com


--
To unsubscribe from this list: send an email with
"unsubscribe kernelnewbies" to ecartis@nl.linux.org
Please read the FAQ at http://kernelnewbies.org/FAQ
