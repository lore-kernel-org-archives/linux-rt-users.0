Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C232355036
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051876; cv=none; b=tGHnpkOR7RZisAmRAqHRKRPAam0j6eU9YLO3Tr/XIxo9PVRWgC3NKibh7y5vluZZGwM8O9XcDhOgE+1AC4mT6ngUDHesoEMxbhNmAFlbYzh86gdONW1URR6CS3SosVz2kmMiS3k8k3LpxJ4RoYUCU/Sc30Jv4erqqkp2oP5Envw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051876; c=relaxed/simple;
	bh=MC6XOE7cazEilFN7MPpWvbzTjsfZzJHreWHpcaz57w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a86BdzzV1p7U6hiZDzyspCwkuU5buulDVU0kjPQQr5RB/4n/HLCCpNgwljeCHuVuJ4Yl+G4SQ1LV7OX/+REGUoehBmUSZfnLt+4w7qHIJZQmtbvIrGysrtIzZAnpjsZ6x/0mUHMq2oQhVwjfnNpHWkCt0hHbgg3fe1ZbjkmDTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C855C4CEF1;
	Tue, 21 Oct 2025 13:04:35 +0000 (UTC)
Date: Tue, 21 Oct 2025 08:04:33 -0500
From: Clark Williams <williams@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, linux-rt-users@vger.kernel.org,
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <aPeE4f5UJYvzjdYY@lysander>
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
 <CAMLffL_a2-RkOJg8kXPZSKhzenu9aPDs4SBz-F97y9-wa_oHHQ@mail.gmail.com>
 <84f6f9f25d0ecc7884e6a3f3f87c03f651545d27.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84f6f9f25d0ecc7884e6a3f3f87c03f651545d27.camel@redhat.com>

On Mon, Oct 20, 2025 at 11:48:16AM -0500, Crystal Wood wrote:
> On Fri, 2025-10-17 at 13:01 +0000, Clark Williams wrote:
> > On Tue, Oct 7, 2025 at 6:51 PM Crystal Wood <crwood@redhat.com> wrote:
> > > 
> > > Speaking of SOPTS, is this tool intended to be Red Hat specific
> > > (and require redhat-rpm-config even if no RPM building is intended)?
> > > 
> > > 
> > 
> > No, I really don't like that we have it there in the main Makefile. 
> > Unfortunately we can't push it to the packaging phase since it
> > affects things generated at compilation time. 
> > 
> > Perhaps we need to have a Makefile variable that identifies a
> > "distro" and triggers inclusion of a Makefile.<distro> that modifies
> > the appropriate flags?  I know it's ugly but I'd like to give other
> > folks (suse, cannonical, etc) a way to tweak the build.  We could
> > default the variable to "redhat" and have a block that includes
> > Makefile.redhat to modify the CFLAGS appropriately. 
> 
> Why can't the specfile build phase pass in the cflags it wants to add
> (after fixing the makefile so that it appends to cflags rather than
> replacing it)?
> 
> Ideally upstream shouldn't have to know about specific distros at all...
> 
> -Crystal
> 

That's a good point. We can have the specfile pass in additions to the 
CFLAGS (or completely override them, I suppose). 

Since Wander and I usually do the package builds for Fedora and CentOS/RHEL,
I'll talk to him about doing just that. 

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
