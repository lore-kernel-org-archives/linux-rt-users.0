From: Len Brown <lenb@kernel.org>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Tue, 27 Jan 2009 13:00:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901271249460.19655@localhost.localdomain>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jon Masters <jcm@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756646AbZA0SBT@vger.kernel.org>
In-reply-to: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Is it possible that if the detector is running,
it may prevent (delay) the thing it is trying to detect?

Eg. some random AML gets interpreted by the kernel,
it needs to touch an MSR, but MSRs are not accessible
from AML, so it triggeres an SMI by touching a magic IO address
with a magic value.

So in this case, the random AML may not run until after
the detector has stopped running, because the detector
prevented some random user-space distro value-add
from polling the battery or the temperature or something...

The other example that comes to mind is that dreaded
USB PS/2 emulation done via SMM.

FWIW I detest SMM as much as any OS person should.
But I also acknowledge that it is virtually impossible to prevent
BIOS developers from giving it up.  We OS types have proposed an
"SMI has happened bit or counter" many times,
even though we'd rather have a "SMM disable" bit:-)

cheers,
--
Len Brown, Intel Open Source Technology Center
