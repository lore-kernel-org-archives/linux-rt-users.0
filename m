From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Tue, 24 Feb 2015 15:13:49 +0100
Message-ID: <1424787229.5419.9.camel@gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	 <1424785301.8767.11.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>,
	Gustavo Bittencourt <gbitten@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424785301.8767.11.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-24 at 14:41 +0100, Mike Galbraith wrote:
> On Mon, 2015-02-23 at 10:06 +0100, Sebastian Andrzej Siewior wrote:
> 
> > - a patch to properly use the rtmutex deadlock detector in ww-mutex
> >   which seems to cure a nouveau deadlock (Gustavo Bittencourt)
> 
> How about the below instead.  In 4.0.0-rt, i915 deadlocked, and the
> below fixed that.  DRM doesn't actually _work_ in 4.0-rt mind you,

Well how 'bout that.  I take that back, there's still something lurking
on my old Toshiba Satellite in 4.0-rt, but my shiny new desktop box now
works fine, whereas it was deadlocking as well (I used it to debug).

[   156.293] (II) Module intel: vendor="X.Org Foundation"
[   156.293]    compiled for 1.16.1, module version = 2.99.916
[   156.293]    Module class: X.Org Video Driver
[   156.293]    ABI class: X.Org Video Driver, version 18.0
[   156.293] (II) intel: Driver for Intel(R) Integrated Graphics Chipsets:
        i810, i810-dc100, i810e, i815, i830M, 845G, 854, 852GM/855GM, 865G,
        915G, E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM,
        Pineview G, 965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q33,
        GM45, 4 Series, G45/G43, Q45/Q43, G41, B43
[   156.294] (II) intel: Driver for Intel(R) HD Graphics: 2000-6000
[   156.294] (II) intel: Driver for Intel(R) Iris(TM) Graphics: 5100, 6100
[   156.294] (II) intel: Driver for Intel(R) Iris(TM) Pro Graphics: 5200, 6200, P6300
[   156.294] (++) using VT number 7

[   156.294] (II) intel(0): Using Kernel Mode Setting driver: i915, version 1.6.0 20150130
[   156.294] (--) intel(0): Integrated Graphics Chipset: Intel(R) HD Graphics 4600
[   156.294] (--) intel(0): CPU: x86-64, sse2, sse3, ssse3, sse4.1, sse4.2, avx, avx2
[   156.294] (II) intel(0): Creating default Display subsection in Screen section
        "intel" for depth/fbbpp 24/32
[   156.294] (==) intel(0): Depth 24, (--) framebuffer bpp 32
[   156.294] (==) intel(0): RGB weight 888
[   156.294] (==) intel(0): Default visual is TrueColor
[   156.294] (II) intel(0): Output VGA1 has no monitor section
[   156.294] (II) intel(0): Enabled output VGA1
[   156.294] (II) intel(0): Output HDMI2 has no monitor section
[   156.294] (II) intel(0): Enabled output HDMI2
[   156.294] (--) intel(0): Using a maximum size of 256x256 for hardware cursors
[   156.294] (II) intel(0): Output VIRTUAL1 has no monitor section
[   156.294] (II) intel(0): Enabled output VIRTUAL1
[   156.294] (--) intel(0): Output VGA1 using initial mode 1680x1050 on pipe 0
[   156.294] (==) intel(0): TearFree disabled
[   156.294] (==) intel(0): DPI set to (96, 96)
[   156.294] (II) Loading sub module "dri2"
[   156.294] (II) LoadModule: "dri2"
[   156.294] (II) Module "dri2" already built-in
[   156.294] (II) Loading sub module "present"
[   156.294] (II) LoadModule: "present"
[   156.294] (II) Module "present" already built-in
[   156.294] (==) Depth 24 pixmap format is 32 bpp
[   156.294] (II) intel(0): SNA initialized with Haswell (gen7.5, gt2) backend
[   156.294] (==) intel(0): Backing store enabled
[   156.294] (==) intel(0): Silken mouse enabled
[   156.294] (II) intel(0): HW Cursor enabled
[   156.294] (II) intel(0): RandR 1.2 enabled, ignore the following RandR disabled message.
[   156.294] (==) intel(0): DPMS enabled
[   156.294] (II) intel(0): [DRI2] Setup complete
[   156.294] (II) intel(0): [DRI2]   DRI driver: i965
[   156.294] (II) intel(0): [DRI2]   VDPAU driver: i965
[   156.294] (II) intel(0): direct rendering: DRI2 enabled
[   156.294] (II) intel(0): hardware support for Present enabled
[   156.294] (==) intel(0): display hotplug detection enabled
[   156.294] (--) RandR disabled
[   156.305] (II) AIGLX: enabled GLX_MESA_copy_sub_buffer
[   156.305] (II) AIGLX: enabled GLX_ARB_create_context
[   156.305] (II) AIGLX: enabled GLX_ARB_create_context_profile
[   156.305] (II) AIGLX: enabled GLX_EXT_create_context_es2_profile
[   156.305] (II) AIGLX: enabled GLX_INTEL_swap_event
[   156.305] (II) AIGLX: enabled GLX_SGI_swap_control and GLX_MESA_swap_control
[   156.305] (II) AIGLX: enabled GLX_EXT_framebuffer_sRGB
[   156.305] (II) AIGLX: enabled GLX_ARB_fbconfig_float
[   156.305] (II) AIGLX: GLX_EXT_texture_from_pixmap backed by buffer objects
[   156.305] (II) AIGLX: enabled GLX_ARB_create_context_robustness
[   156.305] (II) AIGLX: Loaded and initialized i965
[   156.305] (II) GLX: Initialized DRI2 GL provider for screen 0
[   156.307] (II) intel(0): switch to mode 1680x1050@60.0 on VGA1 using pipe 0, position (0, 0), rotation normal, reflection none
[   156.321] (II) intel(0): Setting screen physical size to 444 x 277
