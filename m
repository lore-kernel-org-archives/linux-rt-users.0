From: Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Sun, 08 Nov 2009 10:57:16 -0800
Message-ID: <4AF7148C.9090706@thebigcorporation.com>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com> <20091107210147.3e754278@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091107210147.3e754278-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 11/07/2009 12:01 PM, Jean Delvare wrote:
>
> One thing I do not understand: if yield() is a bug to RT kernels, then
> we would have to remove them all? But so far, yield() still exists in
> the kernel tree, and it serves a purpose. Are you going to ask all
> developers to remove all occurrences of yield() in their code? Doesn't
> sound terribly realistic.
>
>    

The flaw in using yield() with RT priorities, is that it doesn't do what 
you expect.

The scheduler will run, and pick the highest-priority thread, which is 
the one yield()-ing.

So the risk is, that whatever the yield() intended to do, it won't do, 
and worse, that you will end up endlessly yielding to yourself, locking 
the machine.

So the call is for something more explicit of an implementation.

Sven
