From: Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Sat, 7 Nov 2009 20:01:59 +0100
Message-ID: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hello Jean, Ben, -i2c and -rt devs,


during testing the Linux PREEMP_RT work (step-by-step being merged
with mainline) together with I2C functionality I hit the fact that the
I2C
subsystem uses yield() in some of the non-happy code paths (mostly
during chip / address probing etc).

My (embedded) system was running a low-priority real-time work on the
generic workqueue which tried to blink a LED using an I2C I/O
multiplexer
when I hit the BUG where this real-time task ran into the yield() of
try_address().

Grepping through the I2C subsystem code there where more yield()
sprinkled in, without it being clear to me why they are there.


Can those yield()s please be removed, and if they are needed for some
reason (??) be replaced with something equivalent?


I am no longer with this particular project, I do not have the
defconfig and kernel logs at my disposal.

Regards,
-- 
Leon
