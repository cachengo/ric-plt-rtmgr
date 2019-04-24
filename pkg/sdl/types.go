/*
==================================================================================
  Copyright (c) 2019 AT&T Intellectual Property.
  Copyright (c) 2019 Nokia

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
==================================================================================
*/
/*
  Mnemonic:	sdl/types.go
  Abstract:	Containes SDL (Shared Data Layer) specific types
  Date:		16 March 2019
*/
package sdl

import "rtmgr"

type readAll func(string) (*[]rtmgr.XApp, error)
type writeAll func(string, *[]rtmgr.XApp) error

type SdlEngine struct {
	Name     string
	Version  string
	Protocol string
}

type SdlEngineConfig struct {
	Engine      SdlEngine
	ReadAll     readAll
	WriteAll    writeAll
	IsAvailable bool
}