Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A42AD16
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Jan 2026 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826784; cv=none; b=XR6keXa0AootsqUeqhzeMlsh6W+yG41qrsE1MXfU2TlipAJ1kyN060Vwv4whuMoRq/tuvr2SOCFq5BPfibb5sEaVc/2wXDB/XlvGuJmfiCwkKf2qiQCN94lbKyqStysjVX98q/qO/psY2nnP3Xwu/TRUWVapPVAsuZTW1V/Fko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826784; c=relaxed/simple;
	bh=GDYSWvXy81Cxhyh+VSKpiNah8rzUpbSHYA/tUuU/CFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aDQ0nLXHATnq6r+4jWqAo8XpIyIlWZ5L7dGs8zgUsYawGEzHh0+tzTcFxqKNg8ma72xc3xhezn/4olpZHphy87IUp/mk7QYyBcrWtYEqi/G6lkbpkfMCkkmeFWdHRdkEfowNHlsYfyjufP3bdnEHDqiwGcqCTalqecnsVRhysKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXjz1vyv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXjz1vyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD90C4CEF1;
	Wed,  7 Jan 2026 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767826783;
	bh=GDYSWvXy81Cxhyh+VSKpiNah8rzUpbSHYA/tUuU/CFo=;
	h=Date:From:To:Cc:Subject:From;
	b=RXjz1vyvau7vLO64zefPEKmdODyoySus9143Qp3jTTajlgqeoUANrKu5+SajwHJzM
	 QSEX9J63npWVCCPYcqgmLNWQu71bd3B3o5Fk2urnW5lqXXtL8vOkjeirFntpQ/PeQ2
	 1E1jsYj6HK+ajUOpfN5pWlSWqkO5rEAQMGPcbq0LxfNWAtP2jPBRfktCsHl9dmtbJd
	 H/shc4GGxyJcSAL8KOIcW6+IqURcIe5T62mEFB7FBXhs4noQfsddHcMlkNUR1rW4N9
	 J5eeykPagg2PA3vnRDFxsYa1tRJ0gbGSSxhljWbrHJzXD2IyP8NF1MBC+XIHG1gf2v
	 dYBMkJUzhcRKA==
Date: Wed, 7 Jan 2026 16:59:42 -0600
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: David Abdurachmanov <davidlt@rivosinc.com>,
	luffyluo <luffyluo@tencent.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [ANNOUNCE] stalld v1.26.1 released
Message-ID: <aV7lXo_bGDRWnHU7@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, let's try this again without the editor borking up the CC lines and
removing my Subject, sigh...

Hi all,                                                                     
                                                                            
I'm pleased to announce the release of stalld v1.26.1, now available        
at kernel.org, GitLab, and GitHub.                                          
                                                                            
Overview                                                                    
                                                                            
This release focuses on build system improvements, adding RISC-V            
64-bit architecture support and enhancing cross-platform compatibility      
through better compiler flag detection.                                     
                                                                            
New Architecture Support                                                    
                                                                            
RISC-V 64-bit (riscv64)                                                     
- stalld can now be built for RISC-V 64-bit systems                         
- Adds to existing support for x86_64, aarch64, s390x, i686, and            
  powerpc/ppc64le                                                           
                                                                            
Build System Improvements (Wander Lairson Costa)                            
                                                                            
Compiler Flag Detection                                                     
- Added feature detection for -mno-omit-leaf-frame-pointer, fixing          
  builds on s390x and older compilers                                       
- Improved -fcf-protection detection using direct compiler testing          
  instead of GCC version checks                                             
- Removed redundant GCC version check, simplifying the Makefile             
                                                                            
Build Process                                                               
- BPF tool versions (kernel, clang, bpftool) now printed during build       
  for easier debugging of compilation issues                                
- Explicit 'test' target in tests directory for clearer build process       
                                                                            
Bug Fixes                                                                   
                                                                            
- Fixed typo: renamed 'merge_taks_info' to 'merge_tasks_info'               
- Updated .gitignore to exclude development tool metadata                   
                                                                            
Download                                                                    
                                                                            
- https://git.kernel.org/pub/scm/utils/stalld/stalld.git                    
- https://gitlab.com/rt-linux-tools/stalld                                  
- https://github.com/clrkwllms/stalld                                       
                                                                            
git tag: v1.26.1                                                            
                                                                            
Contributors                                                                
                                                                            
- David Abdurachmanov                                                       
- luffyluo                                                                  
- Wander Lairson Costa                                                      
- Clark Williams                                                            
                                                                            
Full release notes: doc/RELEASE_NOTES_v1.26.1.md                            
                                                                            
Best regards,                                                               
Clark Williams        

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
