/*
 
 DocumentInspectorViewController.swift
 
 CotEditor
 https://coteditor.com
 
 Created by 1024jp on 2016-05-31.
 
 ------------------------------------------------------------------------------
 
 © 2016 1024jp
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */

import Cocoa

class DocumentInspectorViewController: NSViewController {
        
    // MARK: Private Properties
    
    private var analyzer: CEDocumentAnalyzer? {
        
        return self.representedObject as? CEDocumentAnalyzer
    }
    
    
    // MARK:
    // MARK: Lifecycle
    
    override var nibName: String? {
        
        return "DocumentInspectorView"
    }
    
    
    
    // MARK: View Controller Methods
    
    /// let documentAnalyzer autoupdate
    override func viewWillAppear() {
        
        self.analyzer?.needsUpdateEditorInfo = true
        self.analyzer?.invalidateEditorInfo()
        
        super.viewWillAppear()
    }
    
    
    /// stop autoupdate documentAnalyzer
    override func viewDidDisappear() {
        
        self.analyzer?.needsUpdateEditorInfo = false
        
        super.viewDidDisappear()
    }
    
    
    /// set analyzer
    override var representedObject: AnyObject? {
        willSet (newObject) {
            guard newObject is CEDocumentAnalyzer else {
                assertionFailure("representedObject of \(self.className) must be an instance of \(CEDocumentAnalyzer.className())")
                return
            }
            self.analyzer?.needsUpdateEditorInfo = false
        }
        
        didSet {
            self.analyzer?.needsUpdateEditorInfo = !self.view.isHidden
        }
    }
    
}
