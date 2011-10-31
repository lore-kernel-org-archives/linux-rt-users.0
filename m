From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Linux RT patch for Pandaboard Omap 4 kernel 3.0.0-1205 error when compiling
Date: Mon, 31 Oct 2011 11:35:35 -0500
Message-ID: <CAFQPvXewJqhaAa-qE+MHLbe-9LWH-s8GshTXJV9YW1d0JhjTaQ@mail.gmail.com>
References: <CAF7pde80C8C=vfN34uR4rS2HZ2-pY0BBJ0EsWm612BgHgtfETw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: HUNG BUI <buihung@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62006 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437Ab1JaQfg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Oct 2011 12:35:36 -0400
Received: by vcge1 with SMTP id e1so4938151vcg.19
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2011 09:35:36 -0700 (PDT)
In-Reply-To: <CAF7pde80C8C=vfN34uR4rS2HZ2-pY0BBJ0EsWm612BgHgtfETw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 26, 2011 at 6:25 PM, HUNG BUI <buihung@gmail.com> wrote:
> Hi everybody,
>
> I am trying to patch and compile realtime patch for kernel 3.0.0-1205
> (TI-OMAP4) on Pandaboard. However I faced lots of error, and couldn't
> finish the compiling process yet.
>
> I followed the instruction of compiling Pandaboard kernel from here
>
> http://adventuresinsilicon.blogspot.com/2011/02/pandaboard-ubuntu-how=
-to-recompile.html
> http://www.omappedia.com/wiki/Ubuntu_kernel_for_OMAP4
>
> My kernel was downloaded with the command :
>
> sudo apt-get build-dep linux-image-$(uname -r)
>
> which is arm-linux-3.0.0-1205-omap4 or linux-ti-omap4
> tar file : linux-ti-omap4_3.0.0-1205.10.tar.gz
> The patch I used is :=A0patch-3.0-rt6.patch.bz2
>
> Pandaboard running on Ubuntu=A0Oneiric Desktop. GCC 4.6
>
> I tried the following commands :
>
> patch -p1 < ../patch-3.0-rt6.patch
> fakeroot debian/rules editconfigs
> (#=A0Kernel Features -> Preemption Model -> Fully Preemptible Kernel =
(RT) )
> fakeroot debian/rules clean
> dpkg-buildpackage -B -uc -us
>
> First the patch showed that there are some :
>
> Reversed (or previously applied) patch detected! Assume - R =A0Apply
> anyway n] with 2 files :
> drivers/rtc/interface.c
> drivers/rtc/rtc-tegra.c
>
> (Don't have this problem if i apply rt8 or latter However they are fo=
r
> kernel 3.0.1 which I don;t know how to get)
>
> I answer No for both assume =A0-r and Apply anyway , I am not sure it=
's
> correct or not
>
> Also the patch showed that there are some hunk failed with 3 files :
>
> arch/arm/mm/cache-l2x0.c
> init/main.c
> kernel/stop_machine.c
> I tried to fix this manually with the .rej files (otherwise it will
> cause this error when compile:
>
> kernel/stop_machine.c:176:2: note: each undeclared identifier is
> reported only once for each function it appears in
> kernel/stop_machine.c: In function =91cpu_stopper_thread=92:
> kernel/stop_machine.c:290:3: error: =91stopper_lock=92 undeclared (fi=
rst
> use in this function)
>
>
> Then when I compile the kernel, i got some more errors which i can
> search and find the way to fix them however when it come to the
> following error, I couldn't find the solution for it=A0:
>
> drivers/dsp/syslink/multicore_ipc/transportshm.c:261:2: error: reques=
t
> for member =91lock=92 in something not a structure or union
> drivers/dsp/syslink/multicore_ipc/transportshm.c:261:2: warning:
> dereferencing =91void *=92 pointer [enabled by default]
> drivers/dsp/syslink/multicore_ipc/transportshm.c:261:2: error: reques=
t
> for member =91lock=92 in something not a structure or union
> make[2]: *** [drivers/dsp/syslink/multicore_ipc/transportshm.o] Error=
 1
>
> I am not sure if the patch (3.0 rt6), kernel(linux-ti-omap4 3.0.0) ,
> gcc (4.6), and the commands i am using is correct, or there is some
> mismatches between them that make more and more errors happened when
> compiling.
>
> Thanks in advance,
>
> Hung Bui
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi Hung,

I recommend building the RT patch against the mainline Linux kernel,
as it would apply clean. If you need to use OMAP kernel git tree, then
you may have to resolve the hunks by yourself. I am not sure how far
off it is from the mainline and how much work applying the patch would
be. I can give you the instructions that I follow to build the
RT-patched kernel for panda board. Hope it is useful to you.

(1) Use a cross-compiler for ARM on x86 development Linux machine (or
a Linux VM). I found code-sourcery toolchain to be simple and easy to
install and use on my x86 Linux development machine. You can get that
from https://sourcery.mentor.com/sgpp/lite/arm/portal/subscription3053
(I think I use "Sourcery G++ Lite 2009q1-161" and use the binary
installer "IA32 GNU/Linux Installer"). Add the code-sourcery
tool-chain to the PATH. (Or, you can use OpenEmbedded toolchain which
is a very common one too)
(2) git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable.git
my3.0.y-stbl-rt
(3) git checkout -b my3.0.6 v3.0.6
(4) As suggested by Frank Rowand in
http://marc.info/?l=3Dlinux-rt-users&m=3D131352000121791&w=3D2 you can
create a default kernel configuration for panda board as follows or
use the .config file he had attached in the same post and tweak it.
(4.1) make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- omap2plus=
_defconfig
(4.2) make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- menuconfi=
g
# this allows USB thumb drive
# Device Drivers -> USB support -> EHCI HCD (USB 2.0) support
CONFIG_USB_EHCI_HCD=3Dy
# Device Drivers -> USB support -> EHCI support for OMAP3 and later chi=
ps
CONFIG_USB_EHCI_HCD_OMAP=3Dy

# ethernet device
# Device Drivers -> Network device support -> USB Network Adapters ->
#  Multi-purpose USB Networking Framework ->
#  SMSC LAN95XX based USB 2.0 10/100 ethernet devices
CONFIG_USB_NET_SMSC95XX=3Dy

# Preeemption model
# Kernel Features -> Preemption Model -> Preemptible Kernel
(Low-Latency Desktop)

(5) make ARCH=3Darm CROSS_COMPILE=3Darm-angstrom-linux-gnueabi- uImage
(5.1) ssh this uImage to your panda board and see whether it works.
panda board sometimes hangs on boot. Resetting and/or power-cycling a
few times will make it boot. If it does not boot at all after several
resets, then it is possible you did not build the kernel correctly. I
usually do this step as a sanity check that there is no major issue
with building and booting the vanilla kernel without the RT patch.
(6) patch -p1 --merge -i <path_of_the_patch_file>/patch-3.0.6-rt17.patc=
h
(7) Run menuconfig again as in Step-4 and choose "Fully Preemptible
Kernel (RT)" as the preemption model.
(8) Build the kernel image and test it as in Step-5.
(9) Run the cyclictest and see the latencies. Latencies are huge
without the high resolution timer.
(10) You can turn on the high-resolution timer (by disabling the 32
KHz Timer and applying the high-resolution timer patch) and measure
the latencies.  There is a bug on panda board (or OMAP4430 in general)
about time-stamps jumping backwards (which appears to be an issue with
the clock source). If you search for my other posts in this mailing
list, you will find info and links about that.

Hope this helps.

Thanks,
Sankara
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
